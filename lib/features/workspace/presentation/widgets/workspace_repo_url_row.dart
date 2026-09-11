import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class WorkspaceRepoUrlRow extends StatelessWidget {
  final String url;
  const WorkspaceRepoUrlRow({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.link, size: 16, color: AppColors.mutedTextColor),
        const SizedBox(width: 6),
        Text(
          url,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.surfaceTint,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
