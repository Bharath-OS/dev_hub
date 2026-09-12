import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_text_styles.dart';

class WorkspaceOverviewCard extends StatelessWidget {
  final double progress;
  final int teamCount;
  final int taskCount;
  final int openPRCount;
  final int developerCount;
  final String milestoneName;
  final String milestoneDue;

  const WorkspaceOverviewCard({
    super.key,
    required this.progress,
    required this.teamCount,
    required this.taskCount,
    required this.openPRCount,
    required this.developerCount,
    required this.milestoneName,
    required this.milestoneDue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppRadius.primaryBorderRadius,
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppSpacing.paddingCard),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overview',
            style: AppTextStyles.title.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.headingTextColor,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Overall progress row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Overall Progress',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.mutedTextColor,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.surfaceTint,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 7,
              backgroundColor: AppColors.outlineVariant,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.surfaceTint,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _StatItem(value: '$teamCount', label: 'TEAMS'),
              _StatItem(value: '$taskCount', label: 'TASKS'),
              _StatItem(value: '$openPRCount', label: 'OPEN PRS'),
              _StatItem(value: '$developerCount', label: 'DEVELOPERS'),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: AppSpacing.md),

          // Active Milestone
          Text(
            'ACTIVE MILESTONE',
            style: AppTextStyles.overline.copyWith(
              color: AppColors.mutedTextColor,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(
                Icons.flag_outlined,
                size: 16,
                color: AppColors.surfaceTint,
              ),
              const SizedBox(width: 6),
              Text(
                milestoneName,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.headingTextColor,
                  fontSize: 13,
                ),
              ),
              const Spacer(),
              Text(
                'Due: $milestoneDue',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.mutedTextColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: AppTextStyles.title.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.headingTextColor,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: AppTextStyles.overline.copyWith(
            color: AppColors.mutedTextColor,
          ),
        ),
      ],
    );
  }
}
