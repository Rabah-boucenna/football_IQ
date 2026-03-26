import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Small stat card used in grids (Profile statistics, quiz-complete chips).
class StatTile extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color accent;

  const StatTile({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.accent = AppColors.pitch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadii.md),
        border: Border.all(color: AppColors.surfaceBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: accent, size: 20),
          const SizedBox(height: 10),
          Text(value, style: AppTextStyles.display.copyWith(fontSize: 20)),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTextStyles.body.copyWith(
              color: AppColors.textSecondary,
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// Inline chip variant used in the quiz-complete summary row.
class StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color accent;

  const StatChip({super.key, required this.icon, required this.label, this.accent = AppColors.gold});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceHigh,
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(color: AppColors.surfaceBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: accent),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTextStyles.body.copyWith(fontSize: 12.5, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
