import 'package:dev_hub/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dev_hub/features/workspace/bloc/workspace_bloc.dart';
import 'package:dev_hub/features/workspace/presentation/widgets/create_workspace_bottom_sheet.dart';
import 'package:dev_hub/features/workspace/presentation/widgets/workspace_card.dart';
import 'package:dev_hub/features/workspace/presentation/widgets/workspace_filter_chips.dart';
import 'package:dev_hub/features/workspace/presentation/widgets/workspace_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../shared/presentation/widgets/custom_bottom_sheet.dart';
import 'workspace_detail_screen.dart';

class WorkspacePage extends StatefulWidget {
  const WorkspacePage({super.key});

  @override
  State<WorkspacePage> createState() => _WorkspacePageState();
}

class _WorkspacePageState extends State<WorkspacePage> {
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
      backgroundColor: AppPalette.background,
      body: SafeArea(
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
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final workspace = state.workspaces[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: WorkspaceCard(
                                  title: workspace.name,
                                  repositoryUrl: workspace.repositoryName,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) =>
                                                const WorkspaceDetailScreen(),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                            childCount: state.workspaces.length,
                          ),
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
                    child: Center(child: Text('Start watching workspaces...')),
                  ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateWorkspaceBottomSheet,
        backgroundColor: AppPalette.primaryContainer,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: AppPalette.white, size: 28),
      ),
    );
  }
}
