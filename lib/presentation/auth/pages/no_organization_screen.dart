import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../widgets/primary_button.dart';
import '../domain/entities/user_entity.dart';
import 'choose_org_screen.dart';
import 'member_only_screen.dart';

class NoOrganizationScreen extends StatelessWidget {
  final UserEntity user;

  const NoOrganizationScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.background,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthOrgAdminSuccess) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => ChooseOrgScreen(user: state.user),
              ),
            );
          } else if (state is AuthNoOrganization) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Still no organizations found. Try again later.'),
                backgroundColor: AppPalette.warning,
              ),
            );
          } else if (state is AuthMemberOnly) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => MemberOnlyScreen(user: state.user),
              ),
            );
          } else if (state is AuthOrgError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppPalette.error,
              ),
            );
          }
        },
        child: SafeArea(
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
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppPalette.warningContainer,
                    ),
                    child: const Icon(
                      Icons.group_off_rounded,
                      size: 48,
                      color: AppPalette.warning,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  Text(
                    'No Organizations Found',
                    style: AppTextStyles.heading.copyWith(
                      color: AppPalette.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.md),

                  Text(
                    'Your GitHub account (${user.githubUsername}) isn\'t a member of any organizations yet. '
                    'Ask an organization admin or team lead to invite you, then come back and check again.',
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
      ),
    );
  }
}
