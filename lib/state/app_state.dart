import 'package:flutter/widgets.dart';

/// Central, in-memory app state: profile, progression and stats.
/// A real build would persist this; for this build it lives for the
/// lifetime of the app session.
class AppState extends ChangeNotifier {
  String username = 'cl';
  String flag = '🇩🇿';
  String country = 'Algeria';

  int level = 27;
  int xp = 7450;
  int xpToNextLevel = 10000;

  int dailyStreak = 17;
  bool dailyChallengeCompletedToday = false;

  int totalScore = 128450;
  int gamesPlayed = 142;
  int correctAnswers = 1180;
  int totalQuestionsAnswered = 1394;
  int bestAnswerStreak = 23;
  int personalBestPoints = 970;

  final Set<String> playersDiscovered = {};

  double get accuracy =>
      totalQuestionsAnswered == 0 ? 0 : correctAnswers / totalQuestionsAnswered;

  double get xpProgress => xpToNextLevel == 0 ? 0 : (xp / xpToNextLevel).clamp(0, 1);

  /// Folds the result of a completed quiz into the player's persistent stats.
  void recordQuizResult({
    required int correct,
    required int total,
    required int pointsEarned,
    required int xpEarned,
    required int sessionBestStreak,
    required Iterable<String> guessedPlayers,
  }) {
    gamesPlayed += 1;
    correctAnswers += correct;
    totalQuestionsAnswered += total;
    totalScore += pointsEarned;
    playersDiscovered.addAll(guessedPlayers);
    if (sessionBestStreak > bestAnswerStreak) {
      bestAnswerStreak = sessionBestStreak;
    }
    if (pointsEarned > personalBestPoints) {
      personalBestPoints = pointsEarned;
    }
    _addXp(xpEarned);
    notifyListeners();
  }

  void recordDailyResult(int pointsEarned, int xpEarned, String playerName) {
    dailyChallengeCompletedToday = true;
    dailyStreak += 1;
    totalScore += pointsEarned;
    playersDiscovered.add(playerName);
    _addXp(xpEarned);
    notifyListeners();
  }

  void _addXp(int amount) {
    xp += amount;
    while (xp >= xpToNextLevel) {
      xp -= xpToNextLevel;
      level += 1;
      xpToNextLevel = (xpToNextLevel * 1.08).round();
    }
  }
}

/// Makes a single [AppState] available to the whole widget tree.
class AppStateScope extends InheritedNotifier<AppState> {
  const AppStateScope({Key? key, required AppState state, required Widget child})
      : super(key: key, notifier: state, child: child);

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppStateScope>();
    assert(scope != null, 'No AppStateScope found in context');
    return scope!.notifier!;
  }
}
