import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_text_styles.dart';

class WorkspaceCard extends StatelessWidget {
  final String title;
  final String repositoryUrl;
  final int teamCount;
  final int memberCount;
  final bool isActive;
  final double progress; // 0.0 to 1.0
  final String dueDate;
  final String badgeText;
  final int badgeCount;
  final VoidCallback? onOptionsTap;
  final VoidCallback? onTap;

  const WorkspaceCard({
    super.key,
    this.title = 'Next dev project',
    this.repositoryUrl = 'github.com/devhub-org',
    this.teamCount = 12,
    this.memberCount = 45,
    this.isActive = true,
    this.progress = 0.68,
    this.dueDate = 'Aug 15, 2026',
    this.badgeText = 'MVP Release',
    this.badgeCount = 3,
    this.onOptionsTap,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      decoration: BoxDecoration(
        color: AppPalette.white,
        borderRadius: AppRadius.primaryBorderRadius,
        border: Border.all(color: AppPalette.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppSpacing.paddingCard),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section: Avatar, Title, Repo, More options, Badge counter
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppPalette.primaryContainer,
                  borderRadius: AppRadius.mdBorderRadius,
                ),
                alignment: Alignment.center,
                child: const Text(
                  'NP',
                  style: TextStyle(
                    color: AppPalette.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm + 4),
              // Title & Repository URL
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: AppTextStyles.title.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppPalette.black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        GestureDetector(
                          onTap: onOptionsTap,
                          child: const Icon(
                            Icons.more_vert,
                            size: 18,
                            color: AppPalette.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.folder_outlined,
                          size: 15,
                          color: AppPalette.mutedTextColor,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            repositoryUrl,
                            style: AppTextStyles.caption.copyWith(
                              fontSize: 13,
                              color: AppPalette.mutedTextColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (badgeCount > 0) ...[
                const SizedBox(width: AppSpacing.sm),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: AppPalette.error,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$badgeCount',
                    style: AppTextStyles.caption.copyWith(
                      color: AppPalette.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // Chips section: Teams, Members, Active Status
          Row(
            children: [
              _buildMetaChip(
                icon: Icons.groups_outlined,
                label: '$teamCount Teams',
              ),
              const SizedBox(width: AppSpacing.sm),
              _buildMetaChip(
                icon: Icons.person_outline,
                label: '$memberCount Members',
              ),
              const Spacer(),
              if (isActive)
                Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: AppPalette.success,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Active',
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppPalette.headingTextColor,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(color: AppPalette.border, height: 1),
          const SizedBox(height: AppSpacing.md),

          // Progress Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progress',
                style: AppTextStyles.caption.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppPalette.mutedTextColor,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: AppTextStyles.caption.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppPalette.primaryContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: AppPalette.outlineVariant,
              valueColor: const AlwaysStoppedAnimation<Color>(AppPalette.primaryContainer),
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Footer: Due Date & Badge Label
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: 15,
                    color: AppPalette.mutedTextColor,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Due: $dueDate',
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppPalette.mutedTextColor,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppPalette.primaryFixed,
                  borderRadius: AppRadius.smBorderRadius,
                ),
                child: Text(
                  badgeText,
                  style: AppTextStyles.caption.copyWith(
                    color: AppPalette.onPrimaryFixedVariant,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    );
  }

  Widget _buildMetaChip({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppPalette.surfaceContainerLow,
        borderRadius: AppRadius.smBorderRadius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: AppPalette.mutedTextColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppPalette.headingTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
