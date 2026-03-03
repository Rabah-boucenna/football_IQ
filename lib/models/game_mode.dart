import 'package:flutter/material.dart';

/// Identifies each of the nine core Football IQ game modes.
enum GameModeId {
  guessPlayer,
  youngPlayer,
  careerPath,
  whoAmI,
  guessByStats,
  guessTeammate,
  transferHistory,
  dailyPlayer,
  footballGrid,
}

/// Static metadata describing a game mode — used to render its card on the
/// Home and Play screens, and to pick clue formatting in the gameplay engine.
class GameMode {
  final GameModeId id;
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> gradient;
  final String badge; // short label shown on the clue card during play, e.g. "GUESS THE PLAYER"

  const GameMode({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
    required this.badge,
  });
}
