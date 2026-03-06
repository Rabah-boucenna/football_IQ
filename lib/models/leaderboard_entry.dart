enum RankTier { bronze, silver, gold, elite, legend }

class LeaderboardEntry {
  final int rank;
  final String username;
  final String flag;
  final String initials;
  final int points;
  final RankTier tier;
  final bool isCurrentUser;

  const LeaderboardEntry({
    required this.rank,
    required this.username,
    required this.flag,
    required this.initials,
    required this.points,
    required this.tier,
    this.isCurrentUser = false,
  });
}
