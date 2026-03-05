import 'package:flutter/material.dart';

class Achievement {
  final String title;
  final IconData icon;
  final bool unlocked;
  final String progress; // e.g. "24/30 days" — shown when locked

  const Achievement({
    required this.title,
    required this.icon,
    required this.unlocked,
    this.progress = '',
  });
}
