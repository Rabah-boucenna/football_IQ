import 'package:flutter/material.dart';

import '../data/mock_leaderboard.dart';
import '../models/leaderboard_entry.dart';
import '../theme/app_theme.dart';
import '../widgets/tier_badge.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  int _tab = 0;

  static const _tabs = ['Global', 'Friends', 'Weekly'];

  List<LeaderboardEntry> get _entries {
    switch (_tab) {
      case 1:
        return friendsLeaderboard;
      case 2:
        return weeklyLeaderboard;
      default:
        return globalLeaderboard;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.md, AppSpacing.md, 0),
            child: Text('Leaderboard', style: AppTextStyles.display.copyWith(fontSize: 26)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.md, 6, AppSpacing.md, AppSpacing.md),
            child: Text(
              'See how you rank against the world.',
              style: AppTextStyles.body.copyWith(color: AppColors.textSecondary, fontSize: 13.5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadii.pill),
                border: Border.all(color: AppColors.surfaceBorder),
              ),
              child: Row(
                children: List.generate(_tabs.length, (i) {
                  final active = i == _tab;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _tab = i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: active ? AppColors.pitch : Colors.transparent,
                          borderRadius: BorderRadius.circular(AppRadii.pill),
                        ),
                        child: Text(
                          _tabs[i],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: active ? const Color(0xFF06120B) : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(AppSpacing.md, 0, AppSpacing.md, 120),
              itemCount: _entries.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, i) => _LeaderboardRow(entry: _entries[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _LeaderboardRow extends StatelessWidget {
  final LeaderboardEntry entry;
  const _LeaderboardRow({required this.entry});

  Color? _medalColor(int rank) {
    switch (rank) {
      case 1:
        return AppColors.tierGold;
      case 2:
        return AppColors.tierSilver;
      case 3:
        return AppColors.tierBronze;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final medal = _medalColor(entry.rank);
    final highlight = entry.isCurrentUser;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 12),
      decoration: BoxDecoration(
        color: highlight ? AppColors.pitchDim : AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        border: Border.all(color: highlight ? AppColors.pitch.withOpacity(0.6) : AppColors.surfaceBorder),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 28,
            child: medal != null
                ? Icon(Icons.emoji_events_rounded, color: medal, size: 20)
                : Text(
                    '${entry.rank}',
                    style: AppTextStyles.body.copyWith(color: AppColors.textMuted, fontWeight: FontWeight.w800),
                  ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.surfaceHigh,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.surfaceBorder),
            ),
            child: Text(entry.initials, style: AppTextStyles.display.copyWith(fontSize: 12)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        entry.username,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(entry.flag, style: const TextStyle(fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 4),
                TierBadge(tier: entry.tier),
              ],
            ),
          ),
          Text(
            '${entry.points}',
            style: AppTextStyles.display.copyWith(fontSize: 15, color: AppColors.gold),
          ),
        ],
      ),
    );
  }
}
