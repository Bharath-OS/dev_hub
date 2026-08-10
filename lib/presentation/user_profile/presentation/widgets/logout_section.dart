import 'package:dev_hub/presentation/user_profile/presentation/widgets/profile_tile_item.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class LogoutSection extends StatelessWidget {
  const LogoutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppPalette.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppPalette.border),
      ),
      child: ProfileTileItem(
        icon: Icons.logout_rounded,
        iconColor: AppPalette.error,
        iconBackgroundColor: AppPalette.errorContainer,
        title: 'Log Out',
        titleColor: AppPalette.error,
        subtitle: 'Sign out from DevHub',
        onTap: () {
          // TODO: Add backend logic to handle user log out session
          print('Clicked: Log Out');
        },
      ),
    );
  }
}