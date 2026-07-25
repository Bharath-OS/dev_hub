import 'package:flutter/material.dart';

/// Spacing constants used throughout the app.
class AppSpacing {
  AppSpacing._();

  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;

  /// Standard card padding
  static const double paddingCard = 16.0;
}

/// Border radius constants used throughout the app.
class AppRadius {
  AppRadius._();

  // Raw radius values
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 20.0;
  static const double xl = 28.0;
  static const double full = 999.0;

  // BorderRadius shorthands
  static final BorderRadius xsBorderRadius = BorderRadius.circular(xs);
  static final BorderRadius smBorderRadius = BorderRadius.circular(sm);
  static final BorderRadius mdBorderRadius = BorderRadius.circular(md);
  static final BorderRadius lgBorderRadius = BorderRadius.circular(lg);
  static final BorderRadius xlBorderRadius = BorderRadius.circular(xl);
  static final BorderRadius fullBorderRadius = BorderRadius.circular(full);

  /// Primary card border radius
  static final BorderRadius primaryBorderRadius = BorderRadius.circular(md);
}

/// Height constants used throughout the app.
class AppHeights {
  AppHeights._();

  /// Standard button height
  static const double buttonHeight = 52.0;

  /// Input field height
  static const double inputHeight = 48.0;

  /// Card minimum height
  static const double cardMinHeight = 80.0;
}
