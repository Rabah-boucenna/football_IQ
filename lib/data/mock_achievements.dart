import 'package:flutter/material.dart';
import '../models/achievement.dart';

const List<Achievement> achievements = [
  Achievement(title: 'Football Expert', icon: Icons.emoji_events_outlined, unlocked: true),
  Achievement(title: '30 Day Streak', icon: Icons.local_fire_department_outlined, unlocked: false, progress: '17/30 days'),
  Achievement(title: '100 Players Guessed', icon: Icons.sports_soccer, unlocked: true),
  Achievement(title: 'Perfect 10/10', icon: Icons.grade_outlined, unlocked: true),
  Achievement(title: 'Football Genius', icon: Icons.workspace_premium_outlined, unlocked: false, progress: 'Level 40 required'),
  Achievement(title: 'Career Path Master', icon: Icons.alt_route, unlocked: false, progress: '38/50 solved'),
];
