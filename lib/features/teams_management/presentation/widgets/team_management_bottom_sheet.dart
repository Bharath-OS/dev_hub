import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../bloc/teams_bloc.dart';

class TeamManagementBottomSheet extends StatefulWidget {
  final String orgName;
  final String workspaceId;
  final String title;
  final String description;
  final String? teamName;
  final String? teamDescription;
  final String repoFullName;
  const TeamManagementBottomSheet({
    super.key,
    required this.title,
    required this.description,
    this.teamName,
    this.teamDescription,
    required this.orgName,
    required this.workspaceId,
    required this.repoFullName,
  });

  @override
  State<TeamManagementBottomSheet> createState() =>
      _TeamsManagementBottomSheetState();
}

class _TeamsManagementBottomSheetState
    extends State<TeamManagementBottomSheet> {
  @override void dispose() {
    _teamNameController.dispose();
    _teamDescriptionController.dispose();
    super.dispose();
  }

  final _teamNameController = TextEditingController();
  final _teamDescriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: AppTextStyles.title.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.headingTextColor,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    widget.description,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.mutedTextColor,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.close,
                color: AppColors.onSurfaceVariant,
              ),
              onPressed: () => Navigator.of(context).pop(),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),

        // Team Name Label and TextField.
        Text(
          'Team Name',
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.headingTextColor,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        TextField(
          controller: _teamNameController,
          decoration: InputDecoration(
            hintText: 'e.g. Frontend Team',
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

        //Teams description
        Text(
          'Team Description (optional)',
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.headingTextColor,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        TextField(
          maxLines: 3,
          controller: _teamDescriptionController,
          decoration: InputDecoration(
            hintText: 'What will this team work on?',
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

        // Create Workspace Button
        SizedBox(
          width: double.infinity,
          height: AppHeights.buttonHeight,
          child: BlocConsumer<TeamsBloc, TeamsState>(
            listener: (context, state) {
              if (state is TeamCreatedState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${state.team.name} Team is created successfully.',
                    ),
                    backgroundColor: AppColors.success,
                  ),
                );
                FocusScope.of(context).unfocus();
                Navigator.of(context).pop();
              } else if (state is TeamFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: AppColors.error,
                  ),
                );
              }
            },
            builder: (context, state) {
              final isLoading = state is LoadingState;

              return ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () {
                        if (_teamNameController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please enter a name for the team',
                              ),
                            ),
                          );
                          return;
                        }

                        final authState = context.read<AuthBloc>().state;

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

                        context.read<TeamsBloc>().add(
                          CreateTeamEvent(
                            orgName: widget.orgName,
                            teamName: _teamNameController.text.trim(),
                            repoFullName: widget.repoFullName,
                            workspaceId: widget.workspaceId,
                            description:
                                _teamDescriptionController.text.trim().isEmpty
                                ? null
                                : _teamDescriptionController.text.trim(),
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryContainer,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppRadius.mdBorderRadius,
                  ),
                  elevation: 0,
                ),
                child: state is LoadingState
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        widget.title,
                        style: AppTextStyles.button.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              );
            },
          ),
        ),
      ],
    );
  }
}
