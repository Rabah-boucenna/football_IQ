import '../models/leaderboard_entry.dart';

const List<LeaderboardEntry> globalLeaderboard = [
  LeaderboardEntry(rank: 1, username: 'kicktactician', flag: '🇧🇷', initials: 'KT', points: 48920, tier: RankTier.legend),
  LeaderboardEntry(rank: 2, username: 'ballonwatcher', flag: '🇪🇸', initials: 'BW', points: 46210, tier: RankTier.legend),
  LeaderboardEntry(rank: 3, username: 'pitchgenius', flag: '🇫🇷', initials: 'PG', points: 44875, tier: RankTier.legend),
  LeaderboardEntry(rank: 4, username: 'tacticnerd', flag: '🇩🇪', initials: 'TN', points: 41330, tier: RankTier.elite),
  LeaderboardEntry(rank: 5, username: 'la_masia_fan', flag: '🇪🇸', initials: 'LM', points: 39980, tier: RankTier.elite),
  LeaderboardEntry(rank: 6, username: 'you', flag: '🇩🇿', initials: 'YO', points: 38540, tier: RankTier.elite, isCurrentUser: true),
  LeaderboardEntry(rank: 7, username: 'derbydayy', flag: '🏴󠁧󠁢󠁥󠁮󠁧󠁿', initials: 'DD', points: 37110, tier: RankTier.elite),
  LeaderboardEntry(rank: 8, username: 'ultras_07', flag: '🇮🇹', initials: 'U7', points: 35400, tier: RankTier.gold),
  LeaderboardEntry(rank: 9, username: 'goldenboot', flag: '🇵🇹', initials: 'GB', points: 33290, tier: RankTier.gold),
  LeaderboardEntry(rank: 10, username: 'clubcrestcollector', flag: '🇳🇱', initials: 'CC', points: 31025, tier: RankTier.gold),
];

const List<LeaderboardEntry> friendsLeaderboard = [
  LeaderboardEntry(rank: 1, username: 'sami_dz', flag: '🇩🇿', initials: 'SD', points: 21500, tier: RankTier.gold),
  LeaderboardEntry(rank: 2, username: 'you', flag: '🇩🇿', initials: 'YO', points: 19870, tier: RankTier.gold, isCurrentUser: true),
  LeaderboardEntry(rank: 3, username: 'walid.f', flag: '🇩🇿', initials: 'WF', points: 17650, tier: RankTier.silver),
  LeaderboardEntry(rank: 4, username: 'nourh', flag: '🇲🇦', initials: 'NH', points: 15420, tier: RankTier.silver),
  LeaderboardEntry(rank: 5, username: 'yassine22', flag: '🇹🇳', initials: 'Y2', points: 12040, tier: RankTier.bronze),
];

const List<LeaderboardEntry> weeklyLeaderboard = [
  LeaderboardEntry(rank: 1, username: 'pitchgenius', flag: '🇫🇷', initials: 'PG', points: 4120, tier: RankTier.legend),
  LeaderboardEntry(rank: 2, username: 'you', flag: '🇩🇿', initials: 'YO', points: 3840, tier: RankTier.elite, isCurrentUser: true),
  LeaderboardEntry(rank: 3, username: 'ultras_07', flag: '🇮🇹', initials: 'U7', points: 3510, tier: RankTier.elite),
  LeaderboardEntry(rank: 4, username: 'kicktactician', flag: '🇧🇷', initials: 'KT', points: 3305, tier: RankTier.gold),
  LeaderboardEntry(rank: 5, username: 'goldenboot', flag: '🇵🇹', initials: 'GB', points: 2990, tier: RankTier.gold),
];
