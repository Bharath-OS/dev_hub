import 'package:flutter/material.dart';

/// Clean and organized color palette for DevHub, strictly following design.md specs.
class AppPalette {
  AppPalette._();

  // Core Brand Colors
  static const Color primary = Color(0xFF1E00A9);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF3525CD);
  static const Color onPrimaryContainer = Color(0xFFB1AFFF);
  static const Color inversePrimary = Color(0xFFC3C0FF);
  static const Color surfaceTint = Color(0xFF4D44E3);

  // Secondary Tones
  static const Color secondary = Color(0xFF585F6C);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFDCE2F3);
  static const Color onSecondaryContainer = Color(0xFF5E6572);

  // Tertiary Tones
  static const Color tertiary = Color(0xFF621500);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFF892200);
  static const Color onTertiaryContainer = Color(0xFFFF9E82);

  // Surfaces & Backgrounds
  static const Color background = Color(0xFFFCF8FF);
  static const Color onBackground = Color(0xFF1B1B24);
  static const Color surface = Color(0xFFFCF8FF);
  static const Color surfaceDim = Color(0xFFDCD8E5);
  static const Color surfaceBright = Color(0xFFFCF8FF);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF5F2FF);
  static const Color surfaceContainer = Color(0xFFF0ECF9);
  static const Color surfaceContainerHigh = Color(0xFFEAE6F4);
  static const Color surfaceContainerHighest = Color(0xFFE4E1EE);
  static const Color onSurface = Color(0xFF1B1B24);
  static const Color onSurfaceVariant = Color(0xFF464555);

  // Outlines & Borders
  static const Color outline = Color(0xFF777587);
  static const Color outlineVariant = Color(0xFFC7C4D8);
  static const Color border = Color(0xFFE5E7EB);

  // Status & Semantic Colors
  // Error / Danger
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  // Success
  static const Color success = Color(0xFF10B981);
  static const Color onSuccess = Color(0xFFFFFFFF);
  static const Color successContainer = Color(0xFFD1FAE5);
  static const Color onSuccessContainer = Color(0xFF065F46);

  // Warning
  static const Color warning = Color(0xFFF59E0B);
  static const Color onWarning = Color(0xFFFFFFFF);
  static const Color warningContainer = Color(0xFFFEF3C7);
  static const Color onWarningContainer = Color(0xFF92400E);

  // Info
  static const Color info = Color(0xFF3B82F6);
  static const Color onInfo = Color(0xFFFFFFFF);
  static const Color infoContainer = Color(0xFFDBEAFE);
  static const Color onInfoContainer = Color(0xFF1E40AF);

  // Fixed Tones
  static const Color primaryFixed = Color(0xFFE2DFFF);
  static const Color primaryFixedDim = Color(0xFFC3C0FF);
  static const Color onPrimaryFixed = Color(0xFF0F0069);
  static const Color onPrimaryFixedVariant = Color(0xFF3323CC);

  static const Color secondaryFixed = Color(0xFFDCE2F3);
  static const Color secondaryFixedDim = Color(0xFFC0C7D6);
  static const Color onSecondaryFixed = Color(0xFF151C27);
  static const Color onSecondaryFixedVariant = Color(0xFF404754);

  static const Color tertiaryFixed = Color(0xFFFFDBD1);
  static const Color tertiaryFixedDim = Color(0xFFFFB5A0);
  static const Color onTertiaryFixed = Color(0xFF3B0900);
  static const Color onTertiaryFixedVariant = Color(0xFF872100);

  // Legacy & Alias Definitions for smooth compatibility
  static const Color bgColor = Color(0xFFFAFAFC);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF111111);
  static const Color neutral = Color(0xFF777587);
  static const Color headingTextColor = Color(0xFF1B1B24);
  static const Color mutedTextColor = Color(0xFF464555);

  // Gradients
  static const Color gradientColor = Color(0xFFE7E2FD);
  static const LinearGradient gradient = LinearGradient(
    colors: [Colors.transparent, Color(0xAAD1CAFD)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient softAccentGradient = LinearGradient(
    colors: [Color(0xFFEAE6F4), Color(0xFFFCF8FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}