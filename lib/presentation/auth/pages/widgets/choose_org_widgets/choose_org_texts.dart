import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/app_text_styles.dart';

class AdminSuccessTitleText extends StatelessWidget {
  const AdminSuccessTitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'You’re an admin! 👋',
      style: AppTextStyles.heading.copyWith(
        color: AppPalette.onSurface,
        fontWeight: FontWeight.w700,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class ChooseOrgSubtitleText extends StatelessWidget {
  const ChooseOrgSubtitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'You have admin access to the following organization(s).\nSelect an organization to manage.',
      style: AppTextStyles.body.copyWith(
        color: AppPalette.onSurfaceVariant,
        height: 1.4,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class YourOrgsHeadingText extends StatelessWidget {
  const YourOrgsHeadingText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Your Organizations',
      style: AppTextStyles.bodyMedium.copyWith(
        color: AppPalette.onSurface,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class TipCardWidget extends StatelessWidget {
  const TipCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppPalette.surfaceContainerLow,
        borderRadius: AppRadius.mdBorderRadius,
        border: Border.all(color: AppPalette.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.lightbulb_outline_rounded,
            color: AppPalette.primary,
            size: 24,
          ),
          const SizedBox(width: AppSpacing.sm + 2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tip',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppPalette.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Admins can manage teams, members, settings and workspace information.',
                  style: AppTextStyles.caption.copyWith(
                    color: AppPalette.onSurfaceVariant,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
