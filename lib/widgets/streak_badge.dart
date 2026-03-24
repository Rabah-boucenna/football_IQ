import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Compact "🔥 N" streak chip, rendered with an icon rather than an emoji
/// glyph so it stays crisp and consistent across devices.
class StreakBadge extends StatelessWidget {
  final int count;
  final bool compact;

  const StreakBadge({super.key, required this.count, this.compact = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: compact ? 10 : 14, vertical: compact ? 6 : 8),
      decoration: BoxDecoration(
        color: AppColors.goldDim,
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(color: AppColors.gold.withOpacity(0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.local_fire_department_rounded, color: AppColors.gold, size: compact ? 16 : 18),
          const SizedBox(width: 4),
          Text(
            '$count',
            style: AppTextStyles.display.copyWith(
              fontSize: compact ? 13 : 15,
              color: AppColors.gold,
            ),
          ),
        ],
      ),
    );
  }
}
