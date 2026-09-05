import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_text_styles.dart';

class WorkspaceFilterChips extends StatefulWidget {
  final ValueChanged<String>? onFilterSelected;

  const WorkspaceFilterChips({
    super.key,
    this.onFilterSelected,
  });

  @override
  State<WorkspaceFilterChips> createState() => _WorkspaceFilterChipsState();
}

class _WorkspaceFilterChipsState extends State<WorkspaceFilterChips> {
  int _selectedIndex = 0;

  final List<String> _filters = ['All', 'Owned', 'Joined', 'Recent', 'Favorites'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        separatorBuilder: (context, index) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final isSelected = _selectedIndex == index;
          final filter = _filters[index];

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
              if (widget.onFilterSelected != null) {
                widget.onFilterSelected!(filter);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryContainer : AppColors.white,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(
                  color: isSelected ? AppColors.primaryContainer : AppColors.border,
                ),
              ),
              child: Center(
                child: Text(
                  filter,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: isSelected ? AppColors.white : AppColors.headingTextColor,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
