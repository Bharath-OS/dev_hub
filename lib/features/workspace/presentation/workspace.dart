import 'package:dev_hub/features/workspace/presentation/widgets/create_workspace_bottom_sheet.dart';
import 'package:dev_hub/features/workspace/presentation/widgets/workspace_card.dart';
import 'package:dev_hub/features/workspace/presentation/widgets/workspace_filter_chips.dart';
import 'package:dev_hub/features/workspace/presentation/widgets/workspace_search_bar.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_bottom_sheet.dart';
import 'workspace_detail_screen.dart';

class WorkspacePage extends StatefulWidget {
  const WorkspacePage({super.key});

  @override
  State<WorkspacePage> createState() => _WorkspacePageState();
}

class _WorkspacePageState extends State<WorkspacePage> {
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WorkspaceSearchBar(),
              const SizedBox(height: 12),
              const WorkspaceFilterChips(),
              const SizedBox(height: 16),
              WorkspaceCard(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const WorkspaceDetailScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateWorkspaceBottomSheet,
        backgroundColor: AppPalette.primaryContainer,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: AppPalette.white,
          size: 28,
        ),
      ),
    );
  }
}