import 'package:dev_hub/core/utils/show_alert_dialog.dart';
import 'package:dev_hub/features/workspace/domain/entity/workspace_entity.dart';
import 'package:dev_hub/features/workspace/presentation/pages/edit_workspace_content.dart';
import 'package:dev_hub/shared/presentation/widgets/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../bloc/workspace_action_bloc/workspace_action_bloc.dart';
import '../workspace_detail_screen.dart';

class WorkspaceCard extends StatelessWidget {
  final WorkspaceEntity workspace;
  final int teamCount;
  final int memberCount;
  final bool isActive;
  final double progress; // 0.0 to 1.0
  final String dueDate;
  final String badgeText;
  final int badgeCount;

  const WorkspaceCard({
    super.key,
    this.teamCount = 12,
    this.memberCount = 45,
    this.isActive = true,
    this.progress = 0.68,
    this.dueDate = 'Aug 15, 2026',
    this.badgeText = 'MVP Release',
    this.badgeCount = 3,
    required this.workspace,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => WorkspaceDetailScreen(workspaceId: workspace.id),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: AppRadius.primaryBorderRadius,
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
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
                    color: AppColors.primaryContainer,
                    borderRadius: AppRadius.mdBorderRadius,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'NP',
                    style: TextStyle(
                      color: AppColors.white,
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
                              workspace.name,
                              style: AppTextStyles.title.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          PopupMenuButton<String>(
                            icon: const Icon(
                              Icons.more_vert,
                              size: 18,
                              color: AppColors.mutedTextColor,
                            ),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            color: AppColors.white,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: AppRadius.smBorderRadius,
                              side: const BorderSide(color: AppColors.border),
                            ),
                            onSelected: (option) async {
                              if (option == 'edit') {
                                CustomBottomSheet.show(
                                  context: context,
                                  child: EditWorkspaceContent(
                                    workspace: workspace,
                                  ),
                                );
                              } else if (option == 'delete') {
                                final result = await showAlertDialog(
                                  context: context,
                                  title: 'Delete Workspace.',
                                  description:
                                      "Do you really want to delete the workspace permanently?\nBy deleting the workspace you will revoke the repository access of the members of the workspace.",
                                );
                                if (result != null && result) {
                                  context.read<WorkspaceActionBloc>().add(
                                    DeleteWorkspaceEvent(workspace),
                                  );
                                }
                              }
                            },
                            itemBuilder: (BuildContext context) => [
                              PopupMenuItem(
                                value: 'edit',
                                height: 36,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.edit_outlined,
                                      size: 16,
                                      color: AppColors.headingTextColor,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Edit",
                                      style: AppTextStyles.caption.copyWith(
                                        fontSize: 13,
                                        color: AppColors.headingTextColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'delete',
                                height: 36,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.delete_outline,
                                      size: 16,
                                      color: AppColors.error,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Delete",
                                      style: AppTextStyles.caption.copyWith(
                                        fontSize: 13,
                                        color: AppColors.error,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.folder_outlined,
                            size: 15,
                            color: AppColors.mutedTextColor,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              workspace.repositoryName,
                              style: AppTextStyles.caption.copyWith(
                                fontSize: 13,
                                color: AppColors.mutedTextColor,
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
                      color: AppColors.error,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$badgeCount',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.white,
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
                          color: AppColors.success,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Active',
                        style: AppTextStyles.caption.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.headingTextColor,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            const Divider(color: AppColors.border, height: 1),
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
                    color: AppColors.mutedTextColor,
                  ),
                ),
                Text(
                  '${(progress * 100).toInt()}%',
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryContainer,
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
                backgroundColor: AppColors.outlineVariant,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.primaryContainer,
                ),
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
                      color: AppColors.mutedTextColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Due: $dueDate',
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.mutedTextColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryFixed,
                    borderRadius: AppRadius.smBorderRadius,
                  ),
                  child: Text(
                    badgeText,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.onPrimaryFixedVariant,
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
        color: AppColors.surfaceContainerLow,
        borderRadius: AppRadius.smBorderRadius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: AppColors.mutedTextColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.headingTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
