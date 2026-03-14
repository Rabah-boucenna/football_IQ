import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import 'home_screen.dart';
import 'play_screen.dart';
import 'leaderboard_screen.dart';
import 'profile_screen.dart';

/// Root shell: four persistent tabs behind the pill bottom nav.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  void _goToTab(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(onSeeAllModes: () => _goToTab(1)),
      const PlayScreen(),
      const LeaderboardScreen(),
      const ProfileScreen(),
    ];
    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: _index, children: screens),
      bottomNavigationBar: FootballIqBottomNav(currentIndex: _index, onSelect: _goToTab),
    );
  }
}
