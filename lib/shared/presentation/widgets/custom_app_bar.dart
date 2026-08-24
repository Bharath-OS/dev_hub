import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onMenuPressed;
  final VoidCallback? onSearchPressed;

  const CustomAppBar({
    super.key,
    this.onMenuPressed,
    this.onSearchPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppPalette.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      // leading: IconButton(
      //   icon: const Icon(Icons.menu, color: AppPalette.black),
      //   onPressed: onMenuPressed,
      // ),
      title: Text(
        'DevHub',
        style: AppTextStyles.title.copyWith(
          color: AppPalette.surfaceTint,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      centerTitle: true,
      // actions: [
      //   IconButton(
      //     icon: const Icon(Icons.search, color: AppPalette.black),
      //     onPressed: onSearchPressed,
      //   ),
      // ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
