import 'package:dev_hub/presentation/pages/user_profile/presentation/widgets/profile_tile_item.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';

class AccountSection extends StatelessWidget {
  const AccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account',
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: AppPalette.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppPalette.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppPalette.border),
          ),
          child: Column(
            children: [
              ProfileTileItem(
                icon: Icons.person_outline,
                title: 'Personal Information',
                subtitle: 'View and edit your profile',
                onTap: () {
                  // TODO: Add backend logic to navigate to Personal Information screen
                  print('Clicked: Personal Information');
                },
              ),
              const Divider(height: 1, color: AppPalette.border),
              ProfileTileItem(
                icon: Icons.code_rounded,
                title: 'GitHub Account',
                subtitle: '@bharathos',
                onTap: () {
                  // TODO: Add backend logic for GitHub account link/manage
                  print('Clicked: GitHub Account');
                },
              ),
              const Divider(height: 1, color: AppPalette.border),
              ProfileTileItem(
                icon: Icons.mail_outline,
                title: 'Email',
                subtitle: 'bharathos@example.com',
                onTap: () {
                  // TODO: Add backend logic to manage email address
                  print('Clicked: Email');
                },
              ),
              const Divider(height: 1, color: AppPalette.border),
              ProfileTileItem(
                icon: Icons.shield_outlined,
                title: 'Security',
                subtitle: 'Change password, Manage sessions',
                onTap: () {
                  // TODO: Add backend logic for Security settings
                  print('Clicked: Security');
                },
              ),
              const Divider(height: 1, color: AppPalette.border),
              ProfileTileItem(
                icon: Icons.smartphone_outlined,
                title: 'Devices',
                subtitle: '2 active sessions',
                onTap: () {
                  // TODO: Add backend logic for active devices session view
                  print('Clicked: Devices');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}