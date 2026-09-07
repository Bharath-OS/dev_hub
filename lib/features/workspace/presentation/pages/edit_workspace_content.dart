import 'package:dev_hub/features/workspace/domain/entity/workspace_entity.dart';
import 'package:dev_hub/shared/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../bloc/workspace_action_bloc/workspace_action_bloc.dart';

class EditWorkspaceContent extends StatefulWidget {
  final WorkspaceEntity workspace;

  const EditWorkspaceContent({super.key, required this.workspace});

  @override
  State<EditWorkspaceContent> createState() => _EditWorkspaceContentState();
}

class _EditWorkspaceContentState extends State<EditWorkspaceContent> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.workspace.name;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WorkspaceActionBloc, WorkspaceActionState>(
      listener: (context, state) {
        if (state is WorkspaceEditedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Workspace updated successfully!'),
              backgroundColor: AppColors.success,
            ),
          );
          Navigator.pop(context);
        } else if (state is WorkspaceActionFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: Column(
        children: [
          Text(
            "Edit Workspace Name",
            style: AppTextStyles.title.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.headingTextColor,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Update your workspace name.',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.mutedTextColor,
            ),
          ),
          //workspace icon selection
          Text(
            'Workspace Icon',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.headingTextColor,
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
                    color: AppColors.primaryContainer,
                    width: 2,
                  ),
                ),
                padding: const EdgeInsets.all(2),
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'D',
                    style: TextStyle(
                      color: AppColors.white,
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
                      color: AppColors.surfaceContainerLow,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.outlineVariant,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: const Icon(
                      Icons.upload,
                      color: AppColors.onSurfaceVariant,
                      size: 20,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Upload',
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: AppColors.mutedTextColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Workspace Name Label & Input
          Text(
            'Workspace Name',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.headingTextColor,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'e.g. Next Dev Project',
              hintStyle: AppTextStyles.body.copyWith(
                color: AppColors.outline,
                fontSize: 14,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: AppRadius.mdBorderRadius,
                borderSide: const BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: AppRadius.mdBorderRadius,
                borderSide: const BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: AppRadius.mdBorderRadius,
                borderSide: const BorderSide(color: AppColors.primaryContainer),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          BlocBuilder<WorkspaceActionBloc, WorkspaceActionState>(
            builder: (context, state) {
              final isLoading = state is WorkspaceEditingState;
              return PrimaryButton(
                isLoading: isLoading,
                text: 'Edit Workspace',
                onPressed: () async {
                  final trimmedName = _controller.text.trim();
                  if (trimmedName.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter a workspace name.'),
                        backgroundColor: AppColors.error,
                      ),
                    );
                    return;
                  }
                  context.read<WorkspaceActionBloc>().add(
                    ModifyWorkspaceEvent(
                      WorkspaceParams(
                        name: trimmedName,
                        id: widget.workspace.id,
                        orgId: widget.workspace.orgId,
                        githubOrgLogin: widget.workspace.githubOrgLogin,
                        repositoryName: widget.workspace.repositoryName,
                        adminId: widget.workspace.adminId,
                        createdAt: widget.workspace.createdAt,
                        updatedAt: DateTime.now(),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
