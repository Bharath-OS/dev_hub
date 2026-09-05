import 'package:dev_hub/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dev_hub/features/workspace/bloc/workspace_action_bloc/workspace_action_bloc.dart'
    hide WorkspaceDisplayState;
import 'package:dev_hub/features/workspace/bloc/workspace_bloc.dart';
import 'package:dev_hub/features/workspace/presentation/widgets/create_workspace_bottom_sheet.dart';
import 'package:dev_hub/features/workspace/presentation/widgets/workspace_card.dart';
import 'package:dev_hub/features/workspace/presentation/widgets/workspace_filter_chips.dart';
import 'package:dev_hub/features/workspace/presentation/widgets/workspace_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../shared/presentation/widgets/custom_bottom_sheet.dart';

class WorkspacePage extends StatefulWidget {
  const WorkspacePage({super.key});

  @override
  State<WorkspacePage> createState() => _WorkspacePageState();
}

class _WorkspacePageState extends State<WorkspacePage> {
  bool _deleteInProgress = false;

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    String? userId;
    if (authState is AuthenticatedState) {
      userId = authState.user.id;
    }
    if (userId != null) {
      context.read<WorkspaceBloc>().add(WatchWorkspacesEvent(userId));
    }
  }

  void _showCreateWorkspaceBottomSheet() {
    CustomBottomSheet.show(
      context: context,
      child: const CreateWorkspaceBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocListener<WorkspaceActionBloc, WorkspaceActionState>(
          listener: (context, state) {
            if (state is WorkspaceDeletingState) {
              _deleteInProgress = true;
            } else if (state is WorkspaceDeletedState) {
              _deleteInProgress = false;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Workspace deleted successfully!'),
                  backgroundColor: AppColors.success,
                ),
              );
            } else if (state is WorkspaceActionFailure) {
              if (_deleteInProgress) {
                _deleteInProgress = false;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: AppColors.error,
                  ),
                );
              }
            } else {
              _deleteInProgress = false;
            }
          },
          child: BlocBuilder<WorkspaceBloc, WorkspaceState>(
            builder: (context, state) {
              return CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        const WorkspaceSearchBar(),
                        const SizedBox(height: 12),
                        const WorkspaceFilterChips(),
                        const SizedBox(height: 16),
                      ]),
                    ),
                  ),
                  if (state is WorkspaceLoadingState)
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (state is WorkspaceDisplayState)
                    state.workspaces.isEmpty
                        ? const SliverFillRemaining(
                            hasScrollBody: false,
                            child: Center(child: Text('No Workspace detected')),
                          )
                        : SliverPadding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate((
                                context,
                                index,
                              ) {
                                final workspace = state.workspaces[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: WorkspaceCard(
                                    workspace: workspace,
                                    memberCount: workspace.members.length,
                                  ),
                                );
                              }, childCount: state.workspaces.length),
                            ),
                          )
                  else if (state is WorkspaceFailure)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(child: Text('Error: ${state.error}')),
                    )
                  else
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text('Start watching workspaces...'),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateWorkspaceBottomSheet,
        backgroundColor: AppColors.primaryContainer,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: AppColors.white, size: 28),
      ),
    );
  }
}
