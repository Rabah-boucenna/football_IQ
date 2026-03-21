import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NavDestination {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const NavDestination({required this.icon, required this.activeIcon, required this.label});
}

const List<NavDestination> navDestinations = [
  NavDestination(icon: Icons.home_outlined, activeIcon: Icons.home_rounded, label: 'Home'),
  NavDestination(icon: Icons.sports_soccer_outlined, activeIcon: Icons.sports_soccer, label: 'Play'),
  NavDestination(icon: Icons.leaderboard_outlined, activeIcon: Icons.leaderboard_rounded, label: 'Leaderboard'),
  NavDestination(icon: Icons.person_outline_rounded, activeIcon: Icons.person_rounded, label: 'Profile'),
];

/// Premium pill-style bottom navigation bar.
class FootballIqBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onSelect;

  const FootballIqBottomNav({super.key, required this.currentIndex, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(AppSpacing.md, 0, AppSpacing.md, AppSpacing.md),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.bgElevated,
        borderRadius: BorderRadius.circular(AppRadii.xl),
        border: Border.all(color: AppColors.surfaceBorder),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 24, offset: const Offset(0, 10)),
        ],
      ),
      child: Row(
        children: List.generate(navDestinations.length, (i) {
          final d = navDestinations[i];
          final active = i == currentIndex;
          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onSelect(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOut,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: active ? AppColors.pitchDim : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppRadii.lg),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      active ? d.activeIcon : d.icon,
                      size: 22,
                      color: active ? AppColors.pitch : AppColors.textMuted,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      d.label,
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: active ? AppColors.pitch : AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
