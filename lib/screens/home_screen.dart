import 'package:flutter/material.dart';

import '../data/mock_modes.dart';
import '../data/question_builder.dart';
import '../models/game_mode.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/game_mode_card.dart';
import '../widgets/silhouette_figure.dart';
import '../widgets/streak_badge.dart';
import '../widgets/xp_bar.dart';
import 'gameplay_screen.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onSeeAllModes;

  const HomeScreen({super.key, required this.onSeeAllModes});

  static const List<GameModeId> _homeGridModes = [
    GameModeId.guessPlayer,
    GameModeId.careerPath,
    GameModeId.youngPlayer,
    GameModeId.whoAmI,
    GameModeId.footballGrid,
    GameModeId.guessByStats,
  ];

  void _openMode(BuildContext context, GameModeId id) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => GameplayScreen(mode: modeById(id), questions: buildQuiz(id))),
    );
  }

  void _openDaily(BuildContext context) {
    final question = buildDailyQuestion(DateTime.now());
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => GameplayScreen(
          mode: modeById(GameModeId.dailyPlayer),
          questions: [question],
          isDaily: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);

    return AnimatedBuilder(
      animation: state,
      builder: (context, _) {
        return SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.md,
              AppSpacing.md,
              120,
            ),
            children: [
              _TopBar(username: state.username, flag: state.flag),
              const SizedBox(height: AppSpacing.lg),
              _ProfileStrip(state: state),
              const SizedBox(height: AppSpacing.lg),
              _DailyHeroCard(state: state, onPlay: () => _openDaily(context)),
              const SizedBox(height: AppSpacing.xl),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Game Modes', style: AppTextStyles.display.copyWith(fontSize: 20)),
                  GestureDetector(
                    onTap: onSeeAllModes,
                    child: Row(
                      children: [
                        Text(
                          'See all',
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.pitch,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                        const Icon(Icons.chevron_right_rounded, color: AppColors.pitch, size: 18),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: AppSpacing.md,
                crossAxisSpacing: AppSpacing.md,
                childAspectRatio: 1.05,
                children: _homeGridModes.map((id) {
                  final mode = modeById(id);
                  return GameModeCard(mode: mode, compact: true, onTap: () => _openMode(context, id));
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TopBar extends StatelessWidget {
  final String username;
  final String flag;
  const _TopBar({required this.username, required this.flag});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.pitch,
            borderRadius: BorderRadius.circular(AppRadii.sm),
          ),
          child: const Icon(Icons.sports_soccer, color: AppColors.bgBase, size: 20),
        ),
        const SizedBox(width: 10),
        Text('FOOTBALL IQ', style: AppTextStyles.display.copyWith(fontSize: 17, letterSpacing: 0.5)),
        const Spacer(),
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.surfaceHigh,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.surfaceBorder),
          ),
          child: Text(username.substring(0, 2).toUpperCase(),
              style: AppTextStyles.display.copyWith(fontSize: 13)),
        ),
      ],
    );
  }
}

class _ProfileStrip extends StatelessWidget {
  final AppState state;
  const _ProfileStrip({required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        border: Border.all(color: AppColors.surfaceBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('${state.flag}  ${state.username}',
                  style: AppTextStyles.display.copyWith(fontSize: 16)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.pitchDim,
                  borderRadius: BorderRadius.circular(AppRadii.pill),
                ),
                child: Text('LVL ${state.level}',
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.pitch,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                    )),
              ),
              const Spacer(),
              StreakBadge(count: state.dailyStreak, compact: true),
            ],
          ),
          const SizedBox(height: 12),
          XpBar(progress: state.xpProgress),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${state.xp} / ${state.xpToNextLevel} XP',
                  style: AppTextStyles.body.copyWith(color: AppColors.textMuted, fontSize: 11.5)),
              Text('${state.totalScore} PTS TOTAL',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

class _DailyHeroCard extends StatelessWidget {
  final AppState state;
  final VoidCallback onPlay;
  const _DailyHeroCard({required this.state, required this.onPlay});

  @override
  Widget build(BuildContext context) {
    final done = state.dailyChallengeCompletedToday;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadii.xl),
        border: Border.all(color: AppColors.surfaceBorder),
        gradient: const RadialGradient(
          center: Alignment(0, -1.1),
          radius: 1.6,
          colors: [Color(0xFF163B29), AppColors.bgElevated],
          stops: [0.0, 0.75],
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.pitchDim,
                  borderRadius: BorderRadius.circular(AppRadii.pill),
                ),
                child: Text('DAILY PLAYER', style: AppTextStyles.eyebrow),
              ),
              const Spacer(),
              StreakBadge(count: state.dailyStreak, compact: true),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          SilhouetteFigure(
            caption: done ? 'Solved today' : 'Mystery footballer',
            accent: AppColors.pitch,
            size: 132,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            done ? 'Nice work — come back tomorrow' : 'Can you guess today\'s player?',
            textAlign: TextAlign.center,
            style: AppTextStyles.body.copyWith(fontSize: 15, color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: done ? null : onPlay,
              style: ElevatedButton.styleFrom(
                disabledBackgroundColor: AppColors.surfaceHigh,
                disabledForegroundColor: AppColors.textMuted,
              ),
              child: Text(done ? 'COMPLETED' : 'PLAY NOW'),
            ),
          ),
        ],
      ),
    );
  }
}
