import 'package:flutter/material.dart';

import '../data/mock_achievements.dart';
import '../models/achievement.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/stat_tile.dart';
import '../widgets/xp_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);

    return AnimatedBuilder(
      animation: state,
      builder: (context, _) {
        final accuracyPct = (state.accuracy * 100).round();
        return SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.md, AppSpacing.md, 120),
            children: [
              Text('Profile', style: AppTextStyles.display.copyWith(fontSize: 26)),
              const SizedBox(height: AppSpacing.lg),
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
                    Container(
                      width: 88,
                      height: 88,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(colors: AppColors.pitchGradient),
                        border: Border.all(color: AppColors.gold, width: 2.4),
                      ),
                      child: Text(
                        state.username.substring(0, 2).toUpperCase(),
                        style: AppTextStyles.display.copyWith(fontSize: 28, color: const Color(0xFF06120B)),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.username, style: AppTextStyles.display.copyWith(fontSize: 20)),
                        const SizedBox(width: 6),
                        Text(state.flag, style: const TextStyle(fontSize: 18)),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      state.country,
                      style: AppTextStyles.body.copyWith(color: AppColors.textSecondary, fontSize: 12.5),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.goldDim,
                        borderRadius: BorderRadius.circular(AppRadii.pill),
                      ),
                      child: Text(
                        'LEVEL ${state.level}',
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.gold,
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    XpBar(progress: state.xpProgress, gradient: AppColors.goldGradient),
                    const SizedBox(height: 6),
                    Text(
                      '${state.xp} / ${state.xpToNextLevel} XP',
                      style: AppTextStyles.body.copyWith(color: AppColors.textMuted, fontSize: 11.5),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text('Statistics', style: AppTextStyles.display.copyWith(fontSize: 18)),
              const SizedBox(height: AppSpacing.md),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: AppSpacing.md,
                crossAxisSpacing: AppSpacing.md,
                childAspectRatio: 1.5,
                children: [
                  StatTile(icon: Icons.videogame_asset_outlined, value: '${state.gamesPlayed}', label: 'Games Played'),
                  StatTile(icon: Icons.check_circle_outline, value: '${state.correctAnswers}', label: 'Correct Answers'),
                  StatTile(icon: Icons.trending_up_rounded, value: '$accuracyPct%', label: 'Accuracy'),
                  StatTile(
                    icon: Icons.local_fire_department_outlined,
                    value: '${state.bestAnswerStreak}',
                    label: 'Best Streak',
                    accent: AppColors.gold,
                  ),
                  StatTile(
                    icon: Icons.today_outlined,
                    value: '${state.dailyStreak}',
                    label: 'Daily Streak',
                    accent: AppColors.gold,
                  ),
                  StatTile(
                    icon: Icons.groups_2_outlined,
                    value: '${state.playersDiscovered.length}',
                    label: 'Players Discovered',
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              Text('Achievements', style: AppTextStyles.display.copyWith(fontSize: 18)),
              const SizedBox(height: AppSpacing.md),
              ...achievements.map((a) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: _AchievementRow(achievement: a),
                  )),
            ],
          ),
        );
      },
    );
  }
}

class _AchievementRow extends StatelessWidget {
  final Achievement achievement;
  const _AchievementRow({required this.achievement});

  @override
  Widget build(BuildContext context) {
    final unlocked = achievement.unlocked;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: unlocked ? AppColors.goldDim : AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadii.md),
        border: Border.all(color: unlocked ? AppColors.gold.withOpacity(0.4) : AppColors.surfaceBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: unlocked ? AppColors.gold.withOpacity(0.18) : AppColors.surfaceHigh,
              shape: BoxShape.circle,
            ),
            child: Icon(
              achievement.icon,
              color: unlocked ? AppColors.gold : AppColors.textMuted,
              size: 20,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  achievement.title,
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: unlocked ? AppColors.textPrimary : AppColors.textSecondary,
                  ),
                ),
                if (!unlocked && achievement.progress.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    achievement.progress,
                    style: AppTextStyles.body.copyWith(color: AppColors.textMuted, fontSize: 12),
                  ),
                ],
              ],
            ),
          ),
          if (unlocked)
            const Icon(Icons.check_circle_rounded, color: AppColors.gold, size: 20)
          else
            const Icon(Icons.lock_outline_rounded, color: AppColors.textMuted, size: 18),
        ],
      ),
    );
  }
}
