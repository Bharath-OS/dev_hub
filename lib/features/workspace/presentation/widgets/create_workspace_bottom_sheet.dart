import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../bloc/workspace_bloc.dart';

class CreateWorkspaceBottomSheet extends StatefulWidget {
  const CreateWorkspaceBottomSheet({super.key});

  @override
  State<CreateWorkspaceBottomSheet> createState() =>
      _CreateWorkspaceBottomSheetState();
}

class _CreateWorkspaceBottomSheetState
    extends State<CreateWorkspaceBottomSheet> {
  final TextEditingController _nameController = TextEditingController();
  String? _selectedRepo;

  @override
  void initState(){
    super.initState();
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
        DropdownButtonFormField<String>(
          initialValue: _selectedRepo,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppPalette.onSurfaceVariant,
          ),
          decoration: InputDecoration(
            prefixIcon: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Icon(Icons.code, color: AppPalette.black),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 40),
            hintText: 'Select Repository',
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
              borderSide: const BorderSide(color: AppPalette.primaryContainer),
            ),
          ),
          items: const [
            DropdownMenuItem(
              value: 'devhub-org/next-dev',
              child: Text('devhub-org/next-dev'),
            ),
            DropdownMenuItem(
              value: 'devhub-org/flutter-app',
              child: Text('devhub-org/flutter-app'),
            ),
          ],
          onChanged: (val) {
            setState(() {
              _selectedRepo = val;
            });
          },
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'You can only select project repositories where you have write or admin permissions.',
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
              // TODO: implement listener
            },
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
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
                    ? CircularProgressIndicator()
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

  void _getRepository() {

  }
}
