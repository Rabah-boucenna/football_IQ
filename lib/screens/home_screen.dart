import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/mock_modes.dart';
import '../data/question_builder.dart';
import '../models/game_mode.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/game_mode_card.dart';
import '../widgets/silhouette_figure.dart';
import '../widgets/streak_badge.dart';
import '../widgets/xp_bar.dart';
import 'gameplay_screen.dart';

/// Home screen.
///
/// Visual direction: a floodlit scoreboard. The daily silhouette is the single
/// loud element on the page — everything around it stays quiet so the eye lands
/// there first. Streak, level and XP live in one place (the identity card) so
/// the same number is never shown twice.
class HomeScreen extends StatelessWidget {
  final VoidCallback onSeeAllModes;

  const HomeScreen({super.key, required this.onSeeAllModes});

  /// Height reserved for the floating bottom navigation bar.
  static const double _bottomNavInset = 112;

  static const List<GameModeId> _homeGridModes = [
    GameModeId.guessPlayer,
    GameModeId.careerPath,
    GameModeId.youngPlayer,
    GameModeId.whoAmI,
    GameModeId.footballGrid,
    GameModeId.guessByStats,
  ];

  void _openMode(BuildContext context, GameModeId id) {
    HapticFeedback.selectionClick();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => GameplayScreen(mode: modeById(id), questions: buildQuiz(id)),
      ),
    );
  }

  void _openDaily(BuildContext context) {
    HapticFeedback.mediumImpact();
    final question = buildDailyQuestion(DateTime.now());
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => GameplayScreen(
          mode: modeById(GameModeId.dailyPlayer),
          questions: [question],
          isDaily: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);

    return SafeArea(
      bottom: false,
      child: ListenableBuilder(
        listenable: state,
        builder: (context, _) {
          return ListView(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.md,
              AppSpacing.md,
              _bottomNavInset + MediaQuery.paddingOf(context).bottom,
            ),
            children: [
              _Reveal(order: 0, child: _TopBar(state: state)),
              const SizedBox(height: AppSpacing.lg),
              _Reveal(order: 1, child: _IdentityCard(state: state)),
              const SizedBox(height: AppSpacing.lg),
              _Reveal(
                order: 2,
                child: _DailyHeroCard(state: state, onPlay: () => _openDaily(context)),
              ),
              const SizedBox(height: AppSpacing.xl),
              _Reveal(
                order: 3,
                child: _SectionHeader(
                  title: 'Game modes',
                  count: _homeGridModes.length,
                  onSeeAll: onSeeAllModes,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              _Reveal(
                order: 4,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: _homeGridModes.length,
                  // Extent-based instead of a fixed column count: two columns on a
                  // phone, three on a tablet or landscape, without a breakpoint list.
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 220,
                    mainAxisSpacing: AppSpacing.md,
                    crossAxisSpacing: AppSpacing.md,
                    childAspectRatio: 1.05,
                  ),
                  itemBuilder: (context, i) {
                    final id = _homeGridModes[i];
                    return GameModeCard(
                      mode: modeById(id),
                      compact: true,
                      onTap: () => _openMode(context, id),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Top bar
// ---------------------------------------------------------------------------

class _TopBar extends StatelessWidget {
  final AppState state;
  const _TopBar({required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.pitch,
            borderRadius: BorderRadius.circular(AppRadii.sm),
            boxShadow: [
              BoxShadow(
                color: AppColors.pitch.withValues(alpha: 0.35),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(Icons.sports_soccer, color: AppColors.bgBase, size: 20),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            'FOOTBALL IQ',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.display.copyWith(fontSize: 17, letterSpacing: 1.2),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        _AvatarWithLevelRing(state: state),
      ],
    );
  }
}

/// Avatar whose ring doubles as the level progress meter — one element, two
/// jobs, and it removes a second XP readout from the top of the screen.
class _AvatarWithLevelRing extends StatelessWidget {
  final AppState state;
  const _AvatarWithLevelRing({required this.state});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Profile, level ${state.level}',
      button: true,
      child: SizedBox(
        width: 44,
        height: 44,
        child: Stack(
          alignment: Alignment.center,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: state.xpProgress.clamp(0.0, 1.0)),
              duration: const Duration(milliseconds: 650),
              curve: Curves.easeOutCubic,
              builder: (context, value, _) => SizedBox(
                width: 44,
                height: 44,
                child: CircularProgressIndicator(
                  value: value,
                  strokeWidth: 2.5,
                  strokeCap: StrokeCap.round,
                  backgroundColor: AppColors.surfaceBorder,
                  valueColor: const AlwaysStoppedAnimation(AppColors.pitch),
                ),
              ),
            ),
            Container(
              width: 34,
              height: 34,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.surfaceHigh,
                shape: BoxShape.circle,
              ),
              child: Text(
                _initials(state.username),
                style: AppTextStyles.display.copyWith(fontSize: 12.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// `substring(0, 2)` throws on a one-character name and on most emoji.
  static String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      final chars = parts.first.characters;
      return chars.take(2).toString().toUpperCase();
    }
    return (parts[0].characters.first + parts[1].characters.first).toUpperCase();
  }
}

// ---------------------------------------------------------------------------
// Identity card
// ---------------------------------------------------------------------------

class _IdentityCard extends StatelessWidget {
  final AppState state;
  const _IdentityCard({required this.state});

  @override
  Widget build(BuildContext context) {
    final remaining = (state.xpToNextLevel - state.xp).clamp(0, state.xpToNextLevel);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        border: Border.all(color: AppColors.surfaceBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(state.flag, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              // Long usernames used to push the level pill off-screen.
              Flexible(
                child: Text(
                  state.username,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.display.copyWith(fontSize: 16),
                ),
              ),
              const SizedBox(width: 8),
              _Pill(
                label: 'LVL ${state.level}',
                background: AppColors.pitchDim,
                foreground: AppColors.pitch,
              ),
              const Spacer(),
              StreakBadge(count: state.dailyStreak, compact: true),
            ],
          ),
          const SizedBox(height: 14),
          XpBar(progress: state.xpProgress.clamp(0.0, 1.0)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // States what the player gets, not just where the bar is.
              Text(
                remaining > 0 ? '$remaining XP to level ${state.level + 1}' : 'Level up ready',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textMuted,
                  fontSize: 11.5,
                ),
              ),
              Text(
                '${state.totalScore} pts',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Daily hero — the signature element
// ---------------------------------------------------------------------------

class _DailyHeroCard extends StatelessWidget {
  final AppState state;
  final VoidCallback onPlay;
  const _DailyHeroCard({required this.state, required this.onPlay});

  @override
  Widget build(BuildContext context) {
    final done = state.dailyChallengeCompletedToday;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadii.xl),
        border: Border.all(
          color: done ? AppColors.surfaceBorder : AppColors.pitchDim,
        ),
        gradient: const RadialGradient(
          center: Alignment(0, -1.1),
          radius: 1.6,
          colors: [Color(0xFF163B29), AppColors.bgElevated],
          stops: [0.0, 0.75],
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _Pill(
                label: 'DAILY PLAYER',
                background: AppColors.pitchDim,
                foreground: AppColors.pitch,
                style: AppTextStyles.eyebrow,
              ),
              const Spacer(),
              // Replaces the duplicated streak badge: this is the only place
              // the card tells you something you can't read elsewhere.
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.schedule_rounded, size: 13, color: AppColors.textMuted),
                  const SizedBox(width: 5),
                  Text(
                    'New in ${_timeUntilReset(DateTime.now())}',
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textMuted,
                      fontSize: 11.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          // Floodlight: a soft pool of pitch light behind the silhouette so the
          // figure reads as lit rather than pasted onto the card.
          Stack(
            alignment: Alignment.center,
            children: [
              IgnorePointer(
                child: Container(
                  width: 210,
                  height: 210,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.pitch.withValues(alpha: done ? 0.06 : 0.16),
                        AppColors.pitch.withValues(alpha: 0.0),
                      ],
                      stops: const [0.0, 1.0],
                    ),
                  ),
                ),
              ),
              SilhouetteFigure(
                caption: done ? 'Solved today' : 'Mystery footballer',
                accent: done ? AppColors.textMuted : AppColors.pitch,
                size: 132,
              ),
              if (done)
                Positioned(
                  right: 34,
                  top: 10,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: AppColors.pitch,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check_rounded, size: 14, color: AppColors.bgBase),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            done
                ? 'Solved. The next player unlocks at midnight.'
                : 'One player, one guess a day. Who is it?',
            textAlign: TextAlign.center,
            style: AppTextStyles.body.copyWith(
              fontSize: 15,
              height: 1.35,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: done ? null : onPlay,
              style: ElevatedButton.styleFrom(
                disabledBackgroundColor: AppColors.surfaceHigh,
                disabledForegroundColor: AppColors.textMuted,
              ),
              child: Text(done ? 'Come back tomorrow' : 'Play today\u2019s player'),
            ),
          ),
        ],
      ),
    );
  }

  static String _timeUntilReset(DateTime now) {
    final reset = DateTime(now.year, now.month, now.day + 1);
    final left = reset.difference(now);
    if (left.inHours >= 1) return '${left.inHours}h ${left.inMinutes % 60}m';
    return '${left.inMinutes}m';
  }
}

// ---------------------------------------------------------------------------
// Section header
// ---------------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  final String title;
  final int count;
  final VoidCallback onSeeAll;

  const _SectionHeader({
    required this.title,
    required this.count,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: AppTextStyles.display.copyWith(fontSize: 20)),
        const SizedBox(width: 8),
        Text(
          '$count',
          style: AppTextStyles.body.copyWith(color: AppColors.textMuted, fontSize: 13),
        ),
        const Spacer(),
        // Was a bare GestureDetector on text — under the 44dp minimum tap target
        // and with no press feedback.
        TextButton(
          onPressed: () {
            HapticFeedback.selectionClick();
            onSeeAll();
          },
          style: TextButton.styleFrom(
            foregroundColor: AppColors.pitch,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            minimumSize: const Size(0, 44),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'See all',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.pitch,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: AppColors.pitch, size: 18),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Small shared pieces
// ---------------------------------------------------------------------------

class _Pill extends StatelessWidget {
  final String label;
  final Color background;
  final Color foreground;
  final TextStyle? style;

  const _Pill({
    required this.label,
    required this.background,
    required this.foreground,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: Text(
        label,
        style: (style ?? AppTextStyles.body).copyWith(
          color: foreground,
          fontSize: style == null ? 11.5 : null,
          fontWeight: style == null ? FontWeight.w800 : null,
        ),
      ),
    );
  }
}

/// Staggered fade-and-rise on first paint. One orchestrated entrance rather
/// than animation scattered across the screen; skipped when the platform
/// asks for reduced motion.
class _Reveal extends StatelessWidget {
  final int order;
  final Widget child;

  const _Reveal({required this.order, required this.child});

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) return child;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 380 + order * 80),
      curve: Curves.easeOutCubic,
      builder: (context, t, child) => Opacity(
        opacity: t,
        child: Transform.translate(offset: Offset(0, (1 - t) * 14), child: child),
      ),
      child: child,
    );
  }
}