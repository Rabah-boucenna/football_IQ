import 'package:flutter/material.dart';

import '../data/mock_modes.dart';
import '../data/question_builder.dart';
import '../models/game_mode.dart';
import '../theme/app_theme.dart';
import '../widgets/game_mode_card.dart';
import 'gameplay_screen.dart';

class PlayScreen extends StatelessWidget {
  const PlayScreen({super.key});

  void _open(BuildContext context, GameModeId id) {
    if (id == GameModeId.dailyPlayer) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => GameplayScreen(
            mode: modeById(id),
            questions: [buildDailyQuestion(DateTime.now())],
            isDaily: true,
          ),
        ),
      );
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => GameplayScreen(mode: modeById(id), questions: buildQuiz(id))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.md, AppSpacing.md, 120),
        children: [
          Text('Play', style: AppTextStyles.display.copyWith(fontSize: 26)),
          const SizedBox(height: 4),
          Text(
            'Pick a challenge and test your Football IQ.',
            style: AppTextStyles.body.copyWith(color: AppColors.textSecondary, fontSize: 13.5),
          ),
          const SizedBox(height: AppSpacing.lg),
          ...gameModes.map(
            (m) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: GameModeCard(mode: m, onTap: () => _open(context, m.id)),
            ),
          ),
        ],
      ),
    );
  }
}
