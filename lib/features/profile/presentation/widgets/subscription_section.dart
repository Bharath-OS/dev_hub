import 'package:dev_hub/features/profile/presentation/widgets/profile_tile_item.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';

class SubscriptionSection extends StatelessWidget {
  const SubscriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Subscription',
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: ProfileTileItem(
            icon: Icons.workspace_premium,
            title: 'Premium Plan',
            subtitle: 'Renews on 24 Aug 2025',
            trailingWidget: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.successContainer,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'ACTIVE',
                style: AppTextStyles.overline.copyWith(
                  color: AppColors.onSuccessContainer,
                ),
              ),
            ),
            onTap: () {
              // TODO: Add backend logic for subscription details
              print('Clicked: Subscription');
            },
          ),
        ),
      ],
    );
  }
}