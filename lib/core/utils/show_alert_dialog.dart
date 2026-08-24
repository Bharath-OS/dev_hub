import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

Future<bool?> showAlertDialog({
  required BuildContext context,
  required String title,
  required String description,
}) async {
  return await showDialog<bool>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: AppPalette.surfaceContainerLowest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        title,
        style: AppTextStyles.title.copyWith(color: AppPalette.onSurface),
      ),
      content: Text(
        description,
        style: AppTextStyles.body.copyWith(color: AppPalette.onSurfaceVariant),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(
            'No',
            style: AppTextStyles.button.copyWith(color: AppPalette.secondary),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(
            'Yes',
            style: AppTextStyles.button.copyWith(color: AppPalette.primary),
          ),
        ),
      ],
    ),
  );
}
