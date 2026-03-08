import 'package:flutter/material.dart';
import '../models/game_mode.dart';
import '../theme/app_theme.dart';

Color _tint(Color c, double amount) => Color.alphaBlend(c.withOpacity(amount), AppColors.surface);

/// All nine Football IQ game modes, in the order they appear on Play.
final List<GameMode> gameModes = [
  GameMode(
    id: GameModeId.guessPlayer,
    title: 'Guess the Player',
    subtitle: 'Identify them from a cropped clue',
    icon: Icons.remove_red_eye_outlined,
    gradient: [_tint(AppColors.pitch, 0.22), AppColors.surface],
    badge: 'GUESS THE PLAYER',
  ),
  GameMode(
    id: GameModeId.careerPath,
    title: 'Career Path',
    subtitle: 'Guess them from their club history',
    icon: Icons.alt_route,
    gradient: [_tint(AppColors.info, 0.20), AppColors.surface],
    badge: 'CAREER PATH',
  ),
  GameMode(
    id: GameModeId.youngPlayer,
    title: 'Young Player',
    subtitle: 'Recognize the future star',
    icon: Icons.child_care_outlined,
    gradient: [_tint(const Color(0xFFE8934A), 0.22), AppColors.surface],
    badge: 'YOUNG PLAYER',
  ),
  GameMode(
    id: GameModeId.whoAmI,
    title: 'Who Am I?',
    subtitle: 'Fewer hints, more points',
    icon: Icons.help_outline,
    gradient: [_tint(AppColors.tierElite, 0.22), AppColors.surface],
    badge: 'WHO AM I?',
  ),
  GameMode(
    id: GameModeId.footballGrid,
    title: 'Football Grid',
    subtitle: 'Name a player who fits both',
    icon: Icons.grid_view_rounded,
    gradient: [_tint(const Color(0xFF6C7CFF), 0.22), AppColors.surface],
    badge: 'FOOTBALL GRID',
  ),
  GameMode(
    id: GameModeId.guessByStats,
    title: 'Guess by Stats',
    subtitle: 'Numbers tell the story',
    icon: Icons.query_stats,
    gradient: [_tint(const Color(0xFF2BD9C8), 0.20), AppColors.surface],
    badge: 'GUESS BY STATS',
  ),
  GameMode(
    id: GameModeId.guessTeammate,
    title: 'Guess the Teammate',
    subtitle: '"I have played with..."',
    icon: Icons.groups_2_outlined,
    gradient: [_tint(const Color(0xFFFF6B8A), 0.20), AppColors.surface],
    badge: 'GUESS THE TEAMMATE',
  ),
  GameMode(
    id: GameModeId.transferHistory,
    title: 'Transfer History',
    subtitle: 'Follow the moves, name the man',
    icon: Icons.swap_horiz_rounded,
    gradient: [_tint(const Color(0xFFFF9F45), 0.20), AppColors.surface],
    badge: 'TRANSFER HISTORY',
  ),
  GameMode(
    id: GameModeId.dailyPlayer,
    title: 'Daily Player',
    subtitle: 'One mystery player, once a day',
    icon: Icons.today_outlined,
    gradient: [_tint(AppColors.gold, 0.22), AppColors.surface],
    badge: 'DAILY PLAYER',
  ),
];

GameMode modeById(GameModeId id) => gameModes.firstWhere((m) => m.id == id);
