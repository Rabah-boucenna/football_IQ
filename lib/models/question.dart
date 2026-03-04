import 'game_mode.dart';
import 'player.dart';

/// One generated quiz question: a mode, the player being guessed, and the
/// progressive list of clue lines revealed as hints.
///
/// [clues] is always at least length 1 — the first entry is shown for free.
/// Revealing hint N costs the player points, per [pointsForHints].
class Question {
  final GameModeId modeId;
  final Player player;
  final List<String> clues;
  final bool isSilhouette; // Guess the Player / Young Player render a figure instead of text-only clue
  final String silhouetteCaption; // caption under the silhouette, e.g. "Only the eyes"

  const Question({
    required this.modeId,
    required this.player,
    required this.clues,
    this.isSilhouette = false,
    this.silhouetteCaption = '',
  });

  static const List<int> hintScoreSteps = [100, 75, 50, 25];

  int pointsForHints(int hintsRevealed) {
    final idx = hintsRevealed.clamp(0, hintScoreSteps.length - 1);
    return hintScoreSteps[idx];
  }
}
