import 'package:flutter/material.dart';
import '../models/leaderboard_entry.dart';
import '../theme/app_theme.dart';

Color tierColor(RankTier tier) {
  switch (tier) {
    case RankTier.bronze:
      return AppColors.tierBronze;
    case RankTier.silver:
      return AppColors.tierSilver;
    case RankTier.gold:
      return AppColors.tierGold;
    case RankTier.elite:
      return AppColors.tierElite;
    case RankTier.legend:
      return AppColors.tierLegend;
  }
}

String tierLabel(RankTier tier) {
  switch (tier) {
    case RankTier.bronze:
      return 'Bronze';
    case RankTier.silver:
      return 'Silver';
    case RankTier.gold:
      return 'Gold';
    case RankTier.elite:
      return 'Elite';
    case RankTier.legend:
      return 'Legend';
  }
}

class TierBadge extends StatelessWidget {
  final RankTier tier;
  const TierBadge({super.key, required this.tier});

  @override
  Widget build(BuildContext context) {
    final color = tierColor(tier);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.16),
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(color: color.withOpacity(0.45)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.shield_rounded, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            tierLabel(tier).toUpperCase(),
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
        ],
      ),
    );
  }
}
