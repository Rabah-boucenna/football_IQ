import 'package:flutter/material.dart';
import '../models/game_mode.dart';
import '../theme/app_theme.dart';

/// A single game-mode card, used on Home (compact grid) and Play (full list).
class GameModeCard extends StatelessWidget {
  final GameMode mode;
  final VoidCallback onTap;
  final bool compact;

  const GameModeCard({super.key, required this.mode, required this.onTap, this.compact = false});

  @override
  Widget build(BuildContext context) {
    final accent = mode.gradient.first;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadii.lg),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        child: Container(
          padding: EdgeInsets.all(compact ? AppSpacing.md : AppSpacing.lg),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: mode.gradient,
            ),
            borderRadius: BorderRadius.circular(AppRadii.lg),
            border: Border.all(color: AppColors.surfaceBorder),
          ),
          child: compact
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _IconBadge(icon: mode.icon, accent: accent),
                    const Spacer(),
                    Text(
                      mode.title,
                      style: AppTextStyles.display.copyWith(fontSize: 15, height: 1.15),
                    ),
                  ],
                )
              : Row(
                  children: [
                    _IconBadge(icon: mode.icon, accent: accent),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(mode.title, style: AppTextStyles.display.copyWith(fontSize: 17)),
                          const SizedBox(height: 3),
                          Text(
                            mode.subtitle,
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
                  ],
                ),
        ),
      ),
    );
  }
}

class _IconBadge extends StatelessWidget {
  final IconData icon;
  final Color accent;
  const _IconBadge({required this.icon, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: accent.withOpacity(0.85),
        borderRadius: BorderRadius.circular(AppRadii.sm),
      ),
      child: Icon(icon, color: AppColors.bgBase, size: 22),
    );
  }
}
