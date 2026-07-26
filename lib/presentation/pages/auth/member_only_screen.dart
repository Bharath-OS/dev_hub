import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../domain/entities/user_entity.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../widgets/primary_button.dart';

class MemberOnlyScreen extends StatelessWidget {
  final UserEntity user;

  const MemberOnlyScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final orgNames = user.allOrganizations
            ?.map((org) => org.login)
            .join(', ') ??
        '';

    return Scaffold(
      backgroundColor: AppPalette.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.marginMobile,
              vertical: AppSpacing.lg,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppPalette.infoContainer,
                  ),
                  child: const Icon(
                    Icons.admin_panel_settings_outlined,
                    size: 48,
                    color: AppPalette.info,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),

                Text(
                  'Admin Access Required',
                  style: AppTextStyles.heading.copyWith(
                    color: AppPalette.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.md),

                Text(
                  'You\'re a member of $orgNames, but you don\'t have admin or owner access in any of them. '
                  'DevHub requires admin privileges to manage workspaces. '
                  'Please ask an organization owner to grant you an admin or owner role, then check again.',
                  style: AppTextStyles.body.copyWith(
                    color: AppPalette.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.xxl),

                PrimaryButton(
                  text: 'Refresh',
                  onPressed: () {
                    context.read<AuthBloc>().add(
                      AuthOrgVerification(user),
                    );
                  },
                  icon: const Icon(
                    Icons.refresh_rounded,
                    size: 20,
                    color: AppPalette.onPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
