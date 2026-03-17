import 'dart:math';

import 'package:flutter/material.dart';

import '../data/mock_modes.dart';
import '../models/game_mode.dart';
import '../models/player.dart';
import '../models/question.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/shake_widget.dart';
import '../widgets/silhouette_figure.dart';
import '../widgets/streak_badge.dart';
import 'quiz_complete_screen.dart';

class GameplayScreen extends StatefulWidget {
  final GameMode mode;
  final List<Question> questions;
  final bool isDaily;

  const GameplayScreen({
    super.key,
    required this.mode,
    required this.questions,
    this.isDaily = false,
  });

  @override
  State<GameplayScreen> createState() => _GameplayScreenState();
}

class _GameplayScreenState extends State<GameplayScreen> {
  int _index = 0;
  int _hintsRevealed = 0;
  bool _answered = false;
  bool _lastCorrect = false;
  int _lastPoints = 0;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  int _sessionCorrect = 0;
  int _sessionPoints = 0;
  int _sessionXp = 0;
  int _currentStreak = 0;
  int _sessionBestStreak = 0;
  final Set<String> _guessedNames = {};
  final List<bool> _resultLog = [];

  Question get _question => widget.questions[_index];

  int get _maxReveals => min(_question.clues.length - 1, Question.hintScoreSteps.length - 1);

  int get _currentPoints => _question.pointsForHints(_hintsRevealed);

  void _revealHint() {
    if (_hintsRevealed >= _maxReveals) return;
    setState(() => _hintsRevealed += 1);
  }

  void _submit() {
    if (_answered) return;
    final correct = _question.player.matchesGuess(_controller.text);
    final points = correct ? _currentPoints : 0;
    setState(() {
      _answered = true;
      _lastCorrect = correct;
      _lastPoints = points;
      _resultLog.add(correct);
      if (correct) {
        _sessionCorrect += 1;
        _sessionPoints += points;
        _sessionXp += points;
        _currentStreak += 1;
        if (_currentStreak > _sessionBestStreak) _sessionBestStreak = _currentStreak;
        _guessedNames.add(_question.player.name);
      } else {
        _currentStreak = 0;
      }
    });
  }

  void _next() {
    final state = AppStateScope.of(context);
    if (_index + 1 < widget.questions.length) {
      setState(() {
        _index += 1;
        _hintsRevealed = 0;
        _answered = false;
        _controller.clear();
      });
      return;
    }

    if (widget.isDaily) {
      state.recordDailyResult(_sessionPoints, _sessionXp, _guessedNames.isNotEmpty ? _guessedNames.first : '');
    } else {
      state.recordQuizResult(
        correct: _sessionCorrect,
        total: widget.questions.length,
        pointsEarned: _sessionPoints,
        xpEarned: _sessionXp,
        sessionBestStreak: _sessionBestStreak,
        guessedPlayers: _guessedNames,
      );
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => QuizCompleteScreen(
          mode: widget.mode,
          isDaily: widget.isDaily,
          totalQuestions: widget.questions.length,
          correctCount: _sessionCorrect,
          pointsEarned: _sessionPoints,
          xpEarned: _sessionXp,
          bestStreak: _sessionBestStreak,
          resultLog: _resultLog,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.questions.length;
    final progress = (_index + (_answered ? 1 : 0)) / total;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                  ),
                  Expanded(
                    child: Text(
                      widget.isDaily ? 'DAILY CHALLENGE' : 'Question ${_index + 1} / $total',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              if (!widget.isDaily)
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadii.pill),
                  child: LinearProgressIndicator(
                    value: progress.clamp(0, 1),
                    minHeight: 6,
                    backgroundColor: AppColors.surfaceHigh,
                    valueColor: const AlwaysStoppedAnimation(AppColors.pitch),
                  ),
                ),
              const SizedBox(height: AppSpacing.lg),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 320),
                  child: _answered
                      ? _ResultView(
                          key: ValueKey('result-$_index'),
                          correct: _lastCorrect,
                          player: _question.player,
                          pointsAwarded: _lastPoints,
                          currentStreak: _currentStreak,
                          isLast: _index + 1 >= total,
                          isDaily: widget.isDaily,
                          onNext: _next,
                        )
                      : _QuestionView(
                          key: ValueKey('question-$_index'),
                          question: _question,
                          hintsRevealed: _hintsRevealed,
                          maxReveals: _maxReveals,
                          currentPoints: _currentPoints,
                          controller: _controller,
                          focusNode: _focusNode,
                          onRevealHint: _revealHint,
                          onSubmit: _submit,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuestionView extends StatelessWidget {
  final Question question;
  final int hintsRevealed;
  final int maxReveals;
  final int currentPoints;
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onRevealHint;
  final VoidCallback onSubmit;

  const _QuestionView({
    super.key,
    required this.question,
    required this.hintsRevealed,
    required this.maxReveals,
    required this.currentPoints,
    required this.controller,
    required this.focusNode,
    required this.onRevealHint,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final visibleClues = question.clues.sublist(0, 1 + hintsRevealed);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadii.xl),
              border: Border.all(color: AppColors.surfaceBorder),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.pitchDim,
                      borderRadius: BorderRadius.circular(AppRadii.pill),
                    ),
                    child: Text(modeById(question.modeId).badge, style: AppTextStyles.eyebrow),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                if (question.isSilhouette)
                  SilhouetteFigure(caption: question.silhouetteCaption, size: 148),
                const SizedBox(height: AppSpacing.md),
                ...List.generate(visibleClues.length, (i) {
                  final isFirst = i == 0;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      visibleClues[i],
                      textAlign: TextAlign.center,
                      style: isFirst
                          ? AppTextStyles.display.copyWith(fontSize: 18, height: 1.3)
                          : AppTextStyles.body.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 14.5,
                              height: 1.4,
                            ),
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 260),
            transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: FadeTransition(opacity: anim, child: child)),
            child: Container(
              key: ValueKey(currentPoints),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Text(
                '$currentPoints PTS',
                style: AppTextStyles.display.copyWith(fontSize: 22, color: AppColors.gold),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          TextField(
            controller: controller,
            focusNode: focusNode,
            textAlign: TextAlign.center,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => onSubmit(),
            style: AppTextStyles.body.copyWith(fontSize: 16, fontWeight: FontWeight.w700),
            decoration: InputDecoration(
              hintText: 'Type player name…',
              hintStyle: AppTextStyles.body.copyWith(color: AppColors.textMuted, fontWeight: FontWeight.w500),
              filled: true,
              fillColor: AppColors.surfaceHigh,
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadii.pill),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadii.pill),
                borderSide: const BorderSide(color: AppColors.pitch, width: 1.6),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ElevatedButton(onPressed: onSubmit, child: const Text('SUBMIT ANSWER')),
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton(
            onPressed: hintsRevealed >= maxReveals ? null : onRevealHint,
            child: Text(hintsRevealed >= maxReveals ? 'NO MORE HINTS' : 'REVEAL HINT'),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}

class _ResultView extends StatelessWidget {
  final bool correct;
  final Player player;
  final int pointsAwarded;
  final int currentStreak;
  final bool isLast;
  final bool isDaily;
  final VoidCallback onNext;

  const _ResultView({
    super.key,
    required this.correct,
    required this.player,
    required this.pointsAwarded,
    required this.currentStreak,
    required this.isLast,
    required this.isDaily,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final content = Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        border: Border.all(color: correct ? AppColors.pitch.withOpacity(0.5) : AppColors.danger.withOpacity(0.4)),
        boxShadow: correct
            ? [BoxShadow(color: AppColors.pitch.withOpacity(0.22), blurRadius: 36, spreadRadius: 2)]
            : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.6, end: 1),
            duration: const Duration(milliseconds: 420),
            curve: Curves.elasticOut,
            builder: (context, value, child) => Transform.scale(scale: value, child: child),
            child: Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: correct ? AppColors.pitchDim : AppColors.dangerDim,
              ),
              child: Icon(
                correct ? Icons.check_rounded : Icons.close_rounded,
                color: correct ? AppColors.pitch : AppColors.danger,
                size: 40,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            correct ? 'CORRECT!' : 'NOT QUITE',
            style: AppTextStyles.display.copyWith(
              fontSize: 22,
              color: correct ? AppColors.pitch : AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            player.name.toUpperCase(),
            textAlign: TextAlign.center,
            style: AppTextStyles.display.copyWith(fontSize: 26, letterSpacing: 0.3),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _Chip(text: '${player.flag} ${player.nationality}'),
              const SizedBox(width: 8),
              _Chip(text: player.position),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          if (correct)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('+$pointsAwarded XP',
                    style: AppTextStyles.display.copyWith(fontSize: 16, color: AppColors.gold)),
                const SizedBox(width: 14),
                StreakBadge(count: currentStreak, compact: true),
              ],
            )
          else
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surfaceHigh,
                borderRadius: BorderRadius.circular(AppRadii.md),
              ),
              child: Text(
                player.fact,
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(color: AppColors.textSecondary, fontSize: 13.5, height: 1.4),
              ),
            ),
          const SizedBox(height: AppSpacing.xl),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onNext,
              child: Text(isLast ? 'SEE RESULTS' : (correct ? 'NEXT PLAYER' : 'NEXT')),
            ),
          ),
        ],
      ),
    );

    if (correct) return content;
    return ShakeWidget(trigger: player.name, child: content);
  }
}

class _Chip extends StatelessWidget {
  final String text;
  const _Chip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceHigh,
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(color: AppColors.surfaceBorder),
      ),
      child: Text(text, style: AppTextStyles.body.copyWith(fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }
}
