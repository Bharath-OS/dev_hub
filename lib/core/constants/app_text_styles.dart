import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Centralized text styles matching design.md specification.
class AppTextStyles {
  AppTextStyles._();

  static const String fontFamily = 'Inter';

  /// Display style: 32px / 28px bold, letter spacing -0.02em
  static const TextStyle display = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 40 / 32,
    letterSpacing: -0.64, // -0.02em
    color: AppPalette.onSurface,
  );

  /// Display Mobile style: 28px bold, letter spacing -0.02em
  static const TextStyle displayMobile = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 36 / 28,
    letterSpacing: -0.56,
    color: AppPalette.onSurface,
  );

  /// Heading style: 24px semi-bold, letter spacing -0.01em
  static const TextStyle heading = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 32 / 24,
    letterSpacing: -0.24,
    color: AppPalette.onSurface,
  );

  /// Title style: 20px semi-bold
  static const TextStyle title = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 28 / 20,
    color: AppPalette.onSurface,
  );

  /// Body style: 16px regular
  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
    color: AppPalette.onSurfaceVariant,
  );

  /// Body Medium style: 16px medium
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 24 / 16,
    color: AppPalette.onSurfaceVariant,
  );

  /// Caption style: 13px medium
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 18 / 13,
    color: AppPalette.outline,
  );

  /// Button text style: 15px semi-bold
  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 20 / 15,
    color: AppPalette.onPrimary,
  );
}
