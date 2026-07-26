import 'package:flutter/material.dart';

/// Centralized UI constants for layout metrics, radii, and component dimensions.
class AppRadius {
  AppRadius._();

  static const double sm = 8.0;
  static const double md = 12.0;
  static const double primary = 18.0; // Signature 18px radius from design.md
  static const double lg = 24.0;
  static const double full = 9999.0;

// BorderRadius shorthands
  static const BorderRadius smBorderRadius = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius mdBorderRadius = BorderRadius.all(Radius.circular(md));
  static const BorderRadius primaryBorderRadius = BorderRadius.all(Radius.circular(primary));
  static const BorderRadius lgBorderRadius = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius fullBorderRadius = BorderRadius.all(Radius.circular(full));
}

/// Spacing constants used throughout the app.
class AppSpacing {
  AppSpacing._();

  static const double base = 8.0;
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;

  // Specific layout paddings from design spec
  static const double marginMobile = 24.0;
  static const double paddingCard = 20.0;
  static const double gutterDesktop = 24.0;
}

class AppHeights {
  AppHeights._();

  static const double buttonHeight = 52.0;
  static const double inputHeight = 56.0;
  static const double fabHeight = 64.0;
  static const double chipHeight = 32.0;
}
