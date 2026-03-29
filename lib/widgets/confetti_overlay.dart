import 'dart:math';

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Lightweight, dependency-free confetti burst for perfect-round celebrations.
class ConfettiOverlay extends StatefulWidget {
  final bool play;
  const ConfettiOverlay({super.key, required this.play});

  @override
  State<ConfettiOverlay> createState() => _ConfettiOverlayState();
}

class _ConfettiOverlayState extends State<ConfettiOverlay> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1800),
  );
  late final List<_ConfettiPiece> _pieces = List.generate(28, (i) {
    final rng = Random(i * 977 + 13);
    return _ConfettiPiece(
      x: rng.nextDouble(),
      delay: rng.nextDouble() * 0.3,
      color: const [AppColors.pitch, AppColors.gold, AppColors.info, AppColors.tierElite][rng.nextInt(4)],
      size: 6 + rng.nextDouble() * 6,
      spin: rng.nextDouble() * 2 - 1,
    );
  });

  @override
  void initState() {
    super.initState();
    if (widget.play) _controller.forward();
  }

  @override
  void didUpdateWidget(covariant ConfettiOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.play && !oldWidget.play) _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.play) return const SizedBox.shrink();
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) => CustomPaint(
          painter: _ConfettiPainter(pieces: _pieces, progress: _controller.value),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class _ConfettiPiece {
  final double x;
  final double delay;
  final Color color;
  final double size;
  final double spin;
  _ConfettiPiece({
    required this.x,
    required this.delay,
    required this.color,
    required this.size,
    required this.spin,
  });
}

class _ConfettiPainter extends CustomPainter {
  final List<_ConfettiPiece> pieces;
  final double progress;
  _ConfettiPainter({required this.pieces, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in pieces) {
      final t = ((progress - p.delay) / (1 - p.delay)).clamp(0.0, 1.0);
      if (t <= 0) continue;
      final dy = t * (size.height + 40) - 20;
      final dx = p.x * size.width + sin(t * pi * 4) * 12;
      final paint = Paint()..color = p.color.withOpacity((1 - t * 0.6).clamp(0.0, 1.0));
      canvas.save();
      canvas.translate(dx, dy);
      canvas.rotate(p.spin * t * pi * 4);
      canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: p.size, height: p.size * 0.5), paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) => oldDelegate.progress != progress;
}
