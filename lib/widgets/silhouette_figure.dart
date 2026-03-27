import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Stylized stand-in for a hidden / cropped player photo — a spotlighted
/// silhouette rather than a real image, used by Guess the Player,
/// Young Player and Daily Player clue cards.
class SilhouetteFigure extends StatelessWidget {
  final String caption;
  final Color accent;
  final double size;

  const SilhouetteFigure({
    super.key,
    required this.caption,
    this.accent = AppColors.pitch,
    this.size = 168,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [accent.withOpacity(0.30), accent.withOpacity(0.0)],
                    stops: const [0.0, 1.0],
                  ),
                ),
              ),
              Container(
                width: size * 0.86,
                height: size * 0.86,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF0D1115),
                  border: Border.all(color: AppColors.surfaceBorder, width: 1.4),
                ),
              ),
              Icon(
                Icons.person_rounded,
                size: size * 0.56,
                color: Colors.black.withOpacity(0.88),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: AppColors.surfaceHigh,
            borderRadius: BorderRadius.circular(AppRadii.pill),
            border: Border.all(color: AppColors.surfaceBorder),
          ),
          child: Text(
            caption.toUpperCase(),
            style: AppTextStyles.eyebrow.copyWith(color: accent, fontSize: 11),
          ),
        ),
      ],
    );
  }
}
