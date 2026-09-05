import 'package:flutter/material.dart';
import '../../../../../../core/constants/app_colors.dart';

class AdminSuccessIllustration extends StatelessWidget {
  const AdminSuccessIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: double.infinity,
      alignment: Alignment.center,
      child: Image.asset(
        'assets/background_images/admin-login-success-bg.png',
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryFixed,
          ),
          child: const Icon(
            Icons.admin_panel_settings_rounded,
            size: 56,
            color: AppColors.primaryContainer,
          ),
        ),
      ),
    );
  }
}
