import 'package:dev_hub/core/utils/show_alert_dialog.dart';
import 'package:dev_hub/features/profile/presentation/widgets/profile_tile_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

class LogoutSection extends StatelessWidget {
  const LogoutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: ProfileTileItem(
        icon: Icons.logout_rounded,
        iconColor: AppColors.error,
        iconBackgroundColor: AppColors.errorContainer,
        title: 'Log Out',
        titleColor: AppColors.error,
        subtitle: 'Sign out from DevHub',
        onTap: () async {
          final bool? shouldLogOut = await showAlertDialog(context: context, title: 'Log Out', description: "Do you want to logout from the app?");
          if(shouldLogOut != null){
            if(shouldLogOut)context.read<AuthBloc>().add(AuthLogOut());
          }
        },
      ),
    );
  }
}