import 'package:dev_hub/core/utils/show_alert_dialog.dart';
import 'package:dev_hub/features/teams_management/bloc/teams_bloc.dart';
import 'package:dev_hub/features/teams_management/bloc/watch_teams_bloc/watch_team_bloc.dart';
import 'package:dev_hub/features/teams_management/domain/entity/team_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_text_styles.dart';

class WorkspaceTeamsGrid extends StatelessWidget {
  final List<TeamEntity> teams;

  const WorkspaceTeamsGrid({super.key, required this.teams});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: teams.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
        childAspectRatio: 1.4,
      ),
      itemBuilder: (context, index) => WorkspaceTeamCard(team: teams[index]),
    );
  }
}

class WorkspaceTeamCard extends StatelessWidget {
  final TeamEntity team;

  const WorkspaceTeamCard({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    // For now, we'll use a placeholder for task progress since TeamEntity doesn't have it yet
    const taskProgress = 0.0;
    final teamColor = Color(
      (team.name.hashCode & 0x00FFFFFF) | 0xFF000000,
    ).withValues(alpha: 0.8);

    return Container(
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
      padding: const EdgeInsets.all(AppSpacing.sm + 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Team avatar
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: teamColor,
                  borderRadius: AppRadius.smBorderRadius,
                ),
                alignment: Alignment.center,
                child: Text(
                  team.name.length >= 2
                      ? team.name.substring(0, 2).toUpperCase()
                      : team.name.toUpperCase(),
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      team.name,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.headingTextColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${team.memberCount} Members',
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 11,
                        color: AppColors.mutedTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                icon: const Icon(
                  Icons.more_vert,
                  size: 16,
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
                    // context.read<WatchTeamBloc>().add(UpdateTeamEvent(originalTeamEntity: team))
                  } else if (option == 'delete') {
                    final shouldDelete = await showAlertDialog(
                      context: context,
                      title: 'Delete Team',
                      description: "Do you really want to delete the team?",
                    );
                    if (shouldDelete != null && shouldDelete) {
                      context.read<TeamsBloc>().add(
                        DeleteTeamEvent(
                          orgName: team.orgName,
                          teamSlug: team.githubTeamSlug,
                          workspaceId: team.workspaceId,
                          teamId: team.id
                        ),
                      );
                    }
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'edit',
                    height: 36,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.edit_outlined,
                          size: 14,
                          color: AppColors.headingTextColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Edit',
                          style: AppTextStyles.caption.copyWith(
                            fontSize: 12,
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
                          size: 14,
                          color: AppColors.error,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Delete',
                          style: AppTextStyles.caption.copyWith(
                            fontSize: 12,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tasks label
              Text(
                '0/0 Tasks', // Placeholder
                style: AppTextStyles.caption.copyWith(
                  fontSize: 11,
                  color: AppColors.mutedTextColor,
                ),
              ),
              const SizedBox(height: 4),
              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: LinearProgressIndicator(
                  value: taskProgress,
                  minHeight: 5,
                  backgroundColor: AppColors.outlineVariant,
                  valueColor: AlwaysStoppedAnimation<Color>(teamColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
