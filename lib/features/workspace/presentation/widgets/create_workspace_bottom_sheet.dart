import 'package:dev_hub/features/workspace/domain/entity/github_repository_entity.dart';
import 'package:dev_hub/features/workspace/domain/usecases/workspace_usecases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../bloc/workspace_bloc.dart';
import '../../domain/entity/workspace_entity.dart';

class CreateWorkspaceBottomSheet extends StatefulWidget {
  const CreateWorkspaceBottomSheet({super.key});

  @override
  State<CreateWorkspaceBottomSheet> createState() =>
      _CreateWorkspaceBottomSheetState();
}

class _CreateWorkspaceBottomSheetState
    extends State<CreateWorkspaceBottomSheet> {
  final TextEditingController _nameController = TextEditingController();
  GitHubRepositoryEntity? _selectedRepo;
  String? _orgName;

  @override
  void initState() {
    super.initState();
    
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthenticatedState) {
      _orgName = authState.user.currentOrganizationLogin;
    }

    if (_orgName != null) {
      if (context.read<WorkspaceBloc>().state is! RepositoriesLoaded) {
        context.read<WorkspaceBloc>().add(GetRepositoriesEvent(_orgName!));
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title & Close Button Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create Workspace',
                    style: AppTextStyles.title.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppPalette.headingTextColor,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Set up your workspace and connect it with a project repository.',
                    style: AppTextStyles.caption.copyWith(
                      color: AppPalette.mutedTextColor,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: AppPalette.onSurfaceVariant),
              onPressed: () => Navigator.of(context).pop(),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),

        // Workspace Icon Section
        Text(
          'Workspace Icon',
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: AppPalette.headingTextColor,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),

        // Single Icon & Upload Button
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Selected Solid Color Icon with active ring border
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppPalette.primaryContainer,
                  width: 2,
                ),
              ),
              padding: const EdgeInsets.all(2),
              child: Container(
                decoration: const BoxDecoration(
                  color: AppPalette.primaryContainer,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Text(
                  'D',
                  style: TextStyle(
                    color: AppPalette.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),

            // Upload Button
            Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppPalette.surfaceContainerLow,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppPalette.outlineVariant,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: const Icon(
                    Icons.upload,
                    color: AppPalette.onSurfaceVariant,
                    size: 20,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Upload',
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppPalette.mutedTextColor,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),

        // Workspace Name Label & Input
        Text(
          'Workspace Name',
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: AppPalette.headingTextColor,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            hintText: 'e.g. Next Dev Project',
            hintStyle: AppTextStyles.body.copyWith(
              color: AppPalette.outline,
              fontSize: 14,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: AppRadius.mdBorderRadius,
              borderSide: const BorderSide(color: AppPalette.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppRadius.mdBorderRadius,
              borderSide: const BorderSide(color: AppPalette.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppRadius.mdBorderRadius,
              borderSide: const BorderSide(color: AppPalette.primaryContainer),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Project Repository Dropdown Label & Field
        Text(
          'Project Repository',
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: AppPalette.headingTextColor,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        BlocBuilder<WorkspaceBloc, WorkspaceState>(
          buildWhen: (previous, current) =>
              current is RepositoriesLoading ||
              current is RepositoriesLoaded ||
              current is RepositoriesFailure,
          builder: (context, state) {
            if (state is RepositoriesLoading) {
              return const LinearProgressIndicator();
            }

            List<GitHubRepositoryEntity> repos = [];
            if (state is RepositoriesLoaded) {
              repos = state.repositories;
            }

            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: DropdownButtonFormField<GitHubRepositoryEntity>(
                    isExpanded: true,
                    initialValue: _selectedRepo,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppPalette.onSurfaceVariant,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.code, color: AppPalette.black),
                      prefixIconConstraints: const BoxConstraints(minWidth: 40),
                      hintText: repos.isEmpty
                          ? 'No Repositories Found'
                          : 'Select Repository',
                      hintStyle: AppTextStyles.body.copyWith(
                        color: AppPalette.mutedTextColor,
                        fontSize: 14,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: AppRadius.mdBorderRadius,
                        borderSide: const BorderSide(color: AppPalette.border),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: AppRadius.mdBorderRadius,
                        borderSide: const BorderSide(color: AppPalette.border),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: AppRadius.mdBorderRadius,
                        borderSide: const BorderSide(
                          color: AppPalette.primaryContainer,
                        ),
                      ),
                    ),
                    items: repos.map((repo) {
                      return DropdownMenuItem<GitHubRepositoryEntity>(
                        value: repo,
                        child: Text(
                          repo.fullName,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _selectedRepo = val;
                      });
                    },
                  ),
                ),
                IconButton.outlined(
                  onPressed: () {
                    if (_orgName == null) {
                      final state = context.read<AuthBloc>().state;
                      if (state is AuthenticatedState) {
                        _orgName = state.user.currentOrganizationLogin;
                      }
                    } else if (_orgName != null) {
                      context.read<WorkspaceBloc>().add(
                        GetRepositoriesEvent(_orgName!),
                      );
                    }
                  },
                  icon: Center(child: Icon(Icons.refresh)),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'If you don’t see the repository you’re looking for, please click the refresh button to reload the list.',
          style: AppTextStyles.caption.copyWith(
            fontSize: 12,
            color: AppPalette.mutedTextColor,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),

        // Create Workspace Button
        SizedBox(
          width: double.infinity,
          height: AppHeights.buttonHeight,
          child: BlocConsumer<WorkspaceBloc, WorkspaceState>(
            listener: (context, state) {
              if (state is WorkspaceCreated) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Workspace created successfully!'),
                    backgroundColor: AppPalette.success,
                  ),
                );
                Navigator.of(context).pop();
              } else if (state is WorkspaceFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: AppPalette.error,
                  ),
                );
              }
            },
            builder: (context, state) {
              final isLoading =
                  state is WorkspaceLoadingState ||
                  state is RepositoriesLoading;

              return ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () {
                        if (_nameController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please enter a name and select a repository.',
                              ),
                            ),
                          );
                          return;
                        }

                        final authState = context.read<AuthBloc>().state;
                        // String? orgId;
                        // String? orgLogin;
                        // String? adminId;

                        if (authState is! AuthenticatedState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Failed to retrieve organization details. Please re-login.',
                              ),
                            ),
                          );
                          return;
                        }
                        final orgId = authState.user.currentOrganizationId;
                        final orgLogin = authState.user.currentOrganizationLogin;
                        final adminId = authState.user.id;

                        if (orgId == null ||
                            orgLogin == null  ) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Failed to retrieve organization details. Please re-login.',
                              ),
                            ),
                          );
                          return;
                        }

                        if (_selectedRepo == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select a repository.'),
                            ),
                          );
                          return;
                        }

                        context.read<WorkspaceBloc>().add(
                          CreateWorkspaceEvent(
                            WorkspaceParams(
                              name: _nameController.text,
                              id: DateTime.now().millisecondsSinceEpoch
                                  .toString(),
                              orgId: orgId,
                              githubOrgLogin: orgLogin,
                              repositoryName: _selectedRepo!.fullName,
                              adminId: adminId,
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now(),
                            ),
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppPalette.primaryContainer,
                  foregroundColor: AppPalette.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppRadius.mdBorderRadius,
                  ),
                  elevation: 0,
                ),
                child: state is WorkspaceLoadingState
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: AppPalette.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'Create Workspace',
                        style: AppTextStyles.button.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              );
            },
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
      ],
    );
  }
}
