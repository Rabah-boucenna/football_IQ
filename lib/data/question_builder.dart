import 'dart:math';

import '../models/game_mode.dart';
import '../models/player.dart';
import '../models/question.dart';
import 'mock_players.dart';

const List<String> _silhouetteCaptions = [
  'Only the eyes',
  'The hairstyle',
  'The beard',
  'A visible tattoo',
  'The silhouette',
  'Part of the kit',
  'Part of the face',
];

List<Player> _samplePlayers(int count, Random rng) {
  final pool = List<Player>.from(mockPlayers)..shuffle(rng);
  return pool.take(count).toList();
}

Question _buildFor(GameModeId modeId, Player p, Random rng) {
  switch (modeId) {
    case GameModeId.guessPlayer:
      final caption = _silhouetteCaptions[rng.nextInt(_silhouetteCaptions.length)];
      return Question(
        modeId: modeId,
        player: p,
        isSilhouette: true,
        silhouetteCaption: caption,
        clues: [
          '${p.flag} ${p.nationality} · ${p.position}',
          'Shirt number ${p.shirtNumber}',
          'Played for ${p.careerClubNames.take(2).join(' → ')}',
          p.trophies.isNotEmpty ? 'Honours: ${p.trophies.first}' : 'A modern-day great',
        ],
      );

    case GameModeId.youngPlayer:
      return Question(
        modeId: modeId,
        player: p,
        isSilhouette: true,
        silhouetteCaption: 'Before the fame',
        clues: [
          'Born ${p.birthYear}',
          '${p.flag} ${p.nationality}',
          '${p.position}',
          'First club: ${p.career.first.club}',
        ],
      );

    case GameModeId.careerPath:
      return Question(
        modeId: modeId,
        player: p,
        clues: [
          p.careerClubNames.join(' → '),
          '${p.flag} ${p.nationality}',
          '${p.position} · shirt #${p.shirtNumber}',
        ],
      );

    case GameModeId.whoAmI:
      return Question(
        modeId: modeId,
        player: p,
        clues: [
          '${p.flag} ${p.nationality}',
          p.position,
          p.career.length >= 2
              ? 'Played for ${p.career[0].club} and ${p.career[1].club}'
              : 'Played for ${p.career.first.club}',
          p.trophies.isNotEmpty ? p.trophies.first : 'A decorated career',
        ],
      );

    case GameModeId.guessByStats:
      return Question(
        modeId: modeId,
        player: p,
        clues: [
          '${p.flag} ${p.nationality}   ·   ${p.position}   ·   #${p.shirtNumber}',
          '${p.goals} goals in ${p.appearances} appearances',
          p.trophies.take(2).join(' · '),
          'Clubs: ${p.careerClubNames.join(', ')}',
        ],
      );

    case GameModeId.guessTeammate:
      return Question(
        modeId: modeId,
        player: p,
        clues: [
          '"I have played with ${p.teammates.join(', ')}. Who am I?"',
          '${p.flag} ${p.nationality}',
          p.position,
          'Clubs include ${p.career.first.club}',
        ],
      );

    case GameModeId.transferHistory:
      return Question(
        modeId: modeId,
        player: p,
        clues: [
          p.career.map((c) => '${c.years}   ${c.club}').join('\n'),
          '${p.flag} ${p.nationality}',
          p.position,
        ],
      );

    case GameModeId.footballGrid:
      final club = p.career.length > 1 ? p.career[1].club : p.career.first.club;
      final trophy = p.trophies.isNotEmpty ? p.trophies.first : 'a major honour';
      return Question(
        modeId: modeId,
        player: p,
        clues: [
          'Played for $club\n+\nWon $trophy',
          '${p.flag} ${p.nationality}',
          p.position,
        ],
      );

    case GameModeId.dailyPlayer:
      return Question(
        modeId: modeId,
        player: p,
        clues: [
          '${p.flag} ${p.nationality}',
          p.position,
          p.career.length >= 2
              ? 'Played for ${p.career[0].club} and ${p.career[1].club}'
              : 'Played for ${p.career.first.club}',
          p.trophies.isNotEmpty ? p.trophies.first : 'A decorated career',
        ],
      );
  }
}

/// Builds a full quiz of [count] unique-player questions for the given mode.
List<Question> buildQuiz(GameModeId modeId, {int count = 10, int? seed}) {
  final rng = Random(seed);
  final players = _samplePlayers(count, rng);
  return players.map((p) => _buildFor(modeId, p, rng)).toList();
}

/// The single Daily Player question — deterministic per calendar day, so
/// every player sees the same mystery footballer.
Question buildDailyQuestion(DateTime date) {
  final dayIndex = int.parse(
    '${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}',
  );
  final player = mockPlayers[dayIndex % mockPlayers.length];
  return _buildFor(GameModeId.dailyPlayer, player, Random(dayIndex));
}
