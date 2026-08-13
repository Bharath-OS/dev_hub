import 'package:dev_hub/presentation/pages/user_profile/presentation/widgets/profile_tile_item.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';

class AdminSection extends StatelessWidget {
  const AdminSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Admin',
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
                icon: Icons.account_tree_outlined,
                title: 'Manage Organizations',
                subtitle: 'View and manage all your organizations',
                onTap: () {
                  // TODO: Add backend logic to manage organizations list
                  print('Clicked: Manage Organizations');
                },
              ),
              const Divider(height: 1, color: AppPalette.border),
              ProfileTileItem(
                icon: Icons.settings_outlined,
                title: 'Workspace Settings',
                subtitle: 'Manage workspace defaults and permissions',
                onTap: () {
                  // TODO: Add backend logic for Workspace Settings
                  print('Clicked: Workspace Settings');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}