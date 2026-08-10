import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class ProfileFooterSection extends StatelessWidget {
  const ProfileFooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Member since 15 Jan 2024',
        style: AppTextStyles.caption.copyWith(
          color: AppPalette.outline,
        ),
      ),
    );
  }
}