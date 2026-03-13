import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Football IQ — core color palette.
/// Dark-mode-first, stadium-at-night mood: deep charcoal backgrounds,
/// a vivid pitch green for primary actions/accents, and a warm gold
/// reserved for premium / rank / achievement moments.
class AppColors {
  AppColors._();

  // Backgrounds
  static const Color bgBase = Color(0xFF0A0D10);
  static const Color bgElevated = Color(0xFF12161B);
  static const Color surface = Color(0xFF171C22);
  static const Color surfaceHigh = Color(0xFF1E242C);
  static const Color surfaceBorder = Color(0xFF262E37);

  // Pitch green (primary)
  static const Color pitch = Color(0xFF2BD97C);
  static const Color pitchDeep = Color(0xFF17A85B);
  static const Color pitchDim = Color(0xFF163B29);

  // Gold (premium / rank / streak)
  static const Color gold = Color(0xFFF0B93A);
  static const Color goldDeep = Color(0xFFC98A1F);
  static const Color goldDim = Color(0xFF3A2E14);

  // Signal colors
  static const Color danger = Color(0xFFFF5A5F);
  static const Color dangerDim = Color(0xFF3A1B1D);
  static const Color info = Color(0xFF4FA6FF);

  // Text
  static const Color textPrimary = Color(0xFFF4F6F8);
  static const Color textSecondary = Color(0xFFA6AFB9);
  static const Color textMuted = Color(0xFF6C7581);

  // Tier colors (leaderboard / rank)
  static const Color tierBronze = Color(0xFFCD7F32);
  static const Color tierSilver = Color(0xFFC3C9D1);
  static const Color tierGold = Color(0xFFF2C94C);
  static const Color tierElite = Color(0xFF8B6BFF);
  static const Color tierLegend = Color(0xFFFF6B4A);

  static const List<Color> heroGradient = [Color(0xFF10241A), Color(0xFF0A0D10)];
  static const List<Color> pitchGradient = [Color(0xFF2BD97C), Color(0xFF17A85B)];
  static const List<Color> goldGradient = [Color(0xFFF6CD65), Color(0xFFC98A1F)];
}

class AppRadii {
  AppRadii._();
  static const double sm = 12;
  static const double md = 18;
  static const double lg = 24;
  static const double xl = 32;
  static const double pill = 999;
}

class AppSpacing {
  AppSpacing._();
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}

class AppTextStyles {
  AppTextStyles._();

  // Display: Sora — geometric, bold, sporty. Used for scores, big numbers, headlines.
  static TextStyle display = GoogleFonts.sora(
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  // Body: Manrope — clean, modern, highly legible at small sizes.
  static TextStyle body = GoogleFonts.manrope(
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static TextStyle eyebrow = GoogleFonts.manrope(
    fontWeight: FontWeight.w800,
    color: AppColors.pitch,
    fontSize: 12,
    letterSpacing: 1.6,
  );
}

class AppTheme {
  AppTheme._();

  static ThemeData dark() {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.bgBase,
      primaryColor: AppColors.pitch,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.pitch,
        secondary: AppColors.gold,
        surface: AppColors.surface,
        error: AppColors.danger,
        onPrimary: Color(0xFF06120B),
        onSecondary: Color(0xFF241A05),
        onSurface: AppColors.textPrimary,
      ),
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      textTheme: GoogleFonts.manropeTextTheme(base.textTheme).apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      ),
      iconTheme: const IconThemeData(color: AppColors.textPrimary),
      dividerColor: AppColors.surfaceBorder,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.pitch,
          foregroundColor: const Color(0xFF06120B),
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.pill),
          ),
          textStyle: GoogleFonts.sora(fontWeight: FontWeight.w700, fontSize: 16),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          side: const BorderSide(color: AppColors.surfaceBorder, width: 1.4),
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.pill),
          ),
          textStyle: GoogleFonts.sora(fontWeight: FontWeight.w700, fontSize: 16),
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.pitch,
        selectionColor: AppColors.pitchDim,
        selectionHandleColor: AppColors.pitch,
      ),
    );
  }
}
