import 'package:flutter/material.dart';

import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_constants.dart';

class AppLogoContainer extends StatelessWidget {
  const AppLogoContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: AppRadius.primaryBorderRadius,
        border: Border.all(color: AppColors.border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Image.asset(
          'assets/background_images/sign_in_bg_image.png',
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) =>
          const Icon(
            Icons.developer_mode_rounded,
            size: 120,
            color: AppColors.primaryContainer,
          ),
        ),
      ),
    );
  }
}
