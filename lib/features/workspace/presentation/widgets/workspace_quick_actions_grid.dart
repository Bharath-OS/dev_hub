import 'package:dev_hub/features/membership/presentation/member%20invitation/pages/invite_member_sheet.dart';
import 'package:dev_hub/features/teams_management/presentation/widgets/team_management_bottom_sheet.dart';
import 'package:dev_hub/features/workspace/domain/entity/workspace_entity.dart';
import 'package:dev_hub/shared/presentation/widgets/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_text_styles.dart';

class WorkspaceQuickActionsGrid extends StatelessWidget {
  final WorkspaceEntity workspace;

  const WorkspaceQuickActionsGrid({super.key, required this.workspace});

  @override
  Widget build(BuildContext context) {
    final actions = [
      _QuickActionData(
        icon: Icons.group_add_outlined,
        label: 'Create Team',
        onTap: () {
          CustomBottomSheet.show(
            context: context,
            child: TeamManagementBottomSheet(
              title: "Create Team",
              description:
                  "Create a new team inside this workspace and connect it with a repository.",
              orgName: workspace.githubOrgLogin,
              workspaceId: workspace.id,
              repoFullName: workspace.repositoryName, isEditing: false,
            ),
          );
        },
      ),
      _QuickActionData(
        icon: Icons.person_add_outlined,
        label: 'Invite Member',
        onTap: () {
          CustomBottomSheet.show(
            context: context,
            child: InviteMemberSheet(workspace: workspace),
          );
        },
      ),
      _QuickActionData(
        icon: Icons.add_task_outlined,
        label: 'Create Task',
        onTap: () {},
      ),
      _QuickActionData(
        icon: Icons.settings_outlined,
        label: 'Workspace Settings',
        onTap: () {},
      ),
    ];

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: actions.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
        childAspectRatio: 2.2,
      ),
      itemBuilder: (context, index) => _QuickActionTile(data: actions[index]),
    );
  }
}

class _QuickActionData {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionData({
    required this.icon,
    required this.label,
    required this.onTap,
  });
}

class _QuickActionTile extends StatelessWidget {
  final _QuickActionData data;

  const _QuickActionTile({required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: data.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: AppRadius.mdBorderRadius,
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(5),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.primaryFixed,
                borderRadius: AppRadius.smBorderRadius,
              ),
              alignment: Alignment.center,
              child: Icon(data.icon, size: 18, color: AppColors.surfaceTint),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                data.label,
                style: AppTextStyles.caption.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.headingTextColor,
                ),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
