import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/question_builder.dart';
import '../models/game_mode.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/confetti_overlay.dart';
import '../widgets/stat_tile.dart';
import 'gameplay_screen.dart';

class QuizCompleteScreen extends StatelessWidget {
  final GameMode mode;
  final bool isDaily;
  final int totalQuestions;
  final int correctCount;
  final int pointsEarned;
  final int xpEarned;
  final int bestStreak;
  final List<bool> resultLog;

  const QuizCompleteScreen({
    super.key,
    required this.mode,
    required this.isDaily,
    required this.totalQuestions,
    required this.correctCount,
    required this.pointsEarned,
    required this.xpEarned,
    required this.bestStreak,
    required this.resultLog,
  });

  int get _accuracy => totalQuestions == 0 ? 0 : ((correctCount / totalQuestions) * 100).round();

  bool get _isPerfect => !isDaily && totalQuestions > 1 && correctCount == totalQuestions;

  String _shareText() {
    final squares = resultLog.map((r) => r ? '🟩' : '🟥').toList();
    final rows = <String>[];
    for (var i = 0; i < squares.length; i += 5) {
      rows.add(squares.sublist(i, i + 5 > squares.length ? squares.length : i + 5).join());
    }
    return 'Football IQ ⚽ $correctCount/$totalQuestions\n${rows.join('\n')}';
  }

  void _shareResult(BuildContext context) {
    Clipboard.setData(ClipboardData(text: _shareText()));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Result copied — paste it anywhere to share!'),
        backgroundColor: AppColors.surfaceHigh,
      ),
    );
  }

  void _playAgain(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => GameplayScreen(mode: mode, questions: buildQuiz(mode.id)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final isPersonalBest = pointsEarned > 0 && pointsEarned == state.personalBestPoints;

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.xl, AppSpacing.lg, AppSpacing.xl),
              child: Column(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: const BoxDecoration(color: AppColors.goldDim, shape: BoxShape.circle),
                    child: const Icon(Icons.emoji_events_rounded, color: AppColors.gold, size: 36),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    isDaily ? 'DAILY COMPLETE' : 'MATCH COMPLETE',
                    style: AppTextStyles.display.copyWith(fontSize: 22, letterSpacing: 0.5),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    mode.title,
                    style: AppTextStyles.body.copyWith(color: AppColors.textSecondary, fontSize: 13.5),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    '$correctCount / $totalQuestions',
                    style: AppTextStyles.display.copyWith(fontSize: 52),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Accuracy $_accuracy%',
                    style: AppTextStyles.body.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Row(
                    children: [
                      Expanded(
                        child: StatTile(
                          icon: Icons.stars_rounded,
                          value: '$pointsEarned',
                          label: 'Points earned',
                          accent: AppColors.gold,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: StatTile(
                          icon: Icons.bolt_rounded,
                          value: '+$xpEarned XP',
                          label: 'Experience',
                          accent: AppColors.pitch,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: [
                      StatChip(
                        icon: Icons.local_fire_department_rounded,
                        label: 'Best streak $bestStreak',
                        accent: AppColors.gold,
                      ),
                      if (isPersonalBest)
                        const StatChip(
                          icon: Icons.emoji_events_rounded,
                          label: 'Personal best',
                          accent: AppColors.gold,
                        ),
                      StatChip(
                        icon: Icons.trending_up_rounded,
                        label: '$_accuracy% accuracy',
                        accent: AppColors.info,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  if (isDaily)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
                        child: const Text('DONE'),
                      ),
                    )
                  else ...[
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(onPressed: () => _playAgain(context), child: const Text('PLAY AGAIN')),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => _shareResult(context),
                        child: const Text('SHARE RESULT'),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    TextButton(
                      onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
                      child: Text(
                        'Back to Home',
                        style: AppTextStyles.body.copyWith(color: AppColors.textMuted, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Positioned.fill(child: ConfettiOverlay(play: _isPerfect)),
        ],
      ),
    );
  }
}
