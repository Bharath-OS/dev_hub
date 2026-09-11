import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class WorkspaceDetailAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  const WorkspaceDetailAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        title,
        style: AppTextStyles.title.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.headingTextColor,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert, color: AppColors.black),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
