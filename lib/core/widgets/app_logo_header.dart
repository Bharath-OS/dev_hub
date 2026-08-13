import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';

/// Reusable branded logo header with subtle depth, smooth border, and shadow.
class AppLogoHeader extends StatelessWidget {
  final double size;
  final String logoPath;

  const AppLogoHeader({
    super.key,
    this.size = 80.0,
    this.logoPath = 'assets/app_icon/app_logo.png',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppPalette.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadius.primary),
        border: Border.all(
          color: AppPalette.border,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppPalette.primary.withAlpha(20),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.primary),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xs),
          child: Image.asset(
            logoPath,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.code_rounded,
                size: size * 0.5,
                color: AppPalette.primaryContainer,
              );
            },
          ),
        ),
      ),
    );
  }
}
