import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Smoothly animated XP / progress fill bar.
class XpBar extends StatelessWidget {
  final double progress; // 0..1
  final double height;
  final List<Color>? gradient;

  const XpBar({super.key, required this.progress, this.height = 10, this.gradient});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadii.pill),
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: Stack(
          children: [
            Container(color: AppColors.surfaceHigh),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: progress.clamp(0, 1)),
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeOutCubic,
              builder: (context, value, _) => FractionallySizedBox(
                widthFactor: value,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: gradient ?? AppColors.pitchGradient),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
