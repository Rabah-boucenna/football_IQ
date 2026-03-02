/// A single club spell, used for career-path and transfer-history clues.
class ClubSpell {
  final String club;
  final String years; // e.g. "2018–2021"

  const ClubSpell(this.club, this.years);
}

/// A footballer in the question bank, with enough factual detail to
/// generate every clue type Football IQ uses.
class Player {
  final String name;
  final List<String> aliases; // accepted alternate spellings / nicknames
  final String flag; // emoji flag
  final String nationality;
  final String position;
  final List<ClubSpell> career; // chronological, first club first
  final List<String> trophies;
  final int goals;
  final int appearances;
  final int shirtNumber;
  final List<String> teammates; // notable players they've lined up with
  final String fact; // one-line trivia shown after answering
  final String birthYear;

  const Player({
    required this.name,
    this.aliases = const [],
    required this.flag,
    required this.nationality,
    required this.position,
    required this.career,
    required this.trophies,
    required this.goals,
    required this.appearances,
    required this.shirtNumber,
    required this.teammates,
    required this.fact,
    required this.birthYear,
  });

  List<String> get careerClubNames => career.map((c) => c.club).toList();

  bool matchesGuess(String guess) {
    final g = guess.trim().toLowerCase();
    if (g.isEmpty) return false;
    if (name.toLowerCase() == g) return true;
    for (final a in aliases) {
      if (a.toLowerCase() == g) return true;
    }
    // Also accept a correct guess of just the surname.
    final surname = name.split(' ').last.toLowerCase();
    if (surname == g) return true;
    return false;
  }
}
