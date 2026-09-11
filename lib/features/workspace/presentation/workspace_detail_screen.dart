import 'package:dev_hub/features/teams_management/bloc/watch_teams_bloc/watch_team_bloc.dart';
import 'package:dev_hub/features/workspace/domain/entity/workspace_entity.dart';
import 'package:dev_hub/features/workspace/presentation/widgets/workspace_detail_app_bar.dart';
import 'package:dev_hub/features/workspace/presentation/widgets/workspace_overview_card.dart';
import 'package:dev_hub/features/workspace/presentation/widgets/workspace_quick_actions_grid.dart';
import 'package:dev_hub/features/workspace/presentation/widgets/workspace_repo_url_row.dart';
import 'package:dev_hub/features/workspace/presentation/widgets/workspace_section_header.dart';
import 'package:dev_hub/features/workspace/presentation/widgets/workspace_teams_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../bloc/workspace_bloc.dart';

class WorkspaceDetailScreen extends StatefulWidget {
  final String workspaceId;
  const WorkspaceDetailScreen({super.key, required this.workspaceId});

  @override
  State<WorkspaceDetailScreen> createState() => _WorkspaceDetailScreenState();
}

class _WorkspaceDetailScreenState extends State<WorkspaceDetailScreen> {
  @override
  void didChangeDependencies() {
    context.read<WatchTeamBloc>().add(WatchAllTeamsEvent(widget.workspaceId));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<WorkspaceBloc>().state as WorkspaceDisplayState;
    final WorkspaceEntity workspace = state.workspaces.firstWhere(
      (workspace) => workspace.id == widget.workspaceId,
    );
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: WorkspaceDetailAppBar(title: workspace.name),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Repository URL row
            WorkspaceRepoUrlRow(url: workspace.repositoryName),
            const SizedBox(height: AppSpacing.lg),

            // Overview card
            const WorkspaceOverviewCard(
              progress: 0.65,
              teamCount: 12,
              taskCount: 45,
              openPRCount: 12,
              developerCount: 8,
              milestoneName: 'MVP Release',
              milestoneDue: 'Aug 15, 2026',
            ),
            const SizedBox(height: AppSpacing.lg),

            // Teams section (grid layout)
            const WorkspaceSectionHeader(title: 'Teams', actionLabel: 'View All'),
            const SizedBox(height: AppSpacing.sm),
            BlocBuilder<WatchTeamBloc, WatchTeamState>(
              builder: (context, state) {
                if (state is TeamsLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is WatchTeamsFailure) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: AppColors.error),
                    ),
                  );
                } else if (state is TeamLoaded) {
                  if (state.teams.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
                        child: Text(
                          'No teams found',
                          style: TextStyle(color: AppColors.mutedTextColor),
                        ),
                      ),
                    );
                  }
                  return WorkspaceTeamsGrid(teams: state.teams);
                }
                return const SizedBox.shrink();
              },
            ),
            const SizedBox(height: AppSpacing.lg),

            // Quick Actions section
            const WorkspaceSectionHeader(title: 'Quick Actions'),
            const SizedBox(height: AppSpacing.sm),
            WorkspaceQuickActionsGrid(workspace: workspace),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }
}
