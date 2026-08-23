import 'package:dev_hub/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';

class ProfileHeaderSection extends StatelessWidget {
  const ProfileHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Column(
          children: [
            // Profile Image with Edit Button
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?fit=crop&w=300&q=80',
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        // TODO: Add backend logic to edit profile avatar
                        print('Clicked: Change Profile Avatar');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: AppPalette.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.edit_sharp,
                          color: AppPalette.onPrimary,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Name
            Center(
              child: state is AuthenticatedState
                  ? Text(state.user.displayName, style: AppTextStyles.heading)
                  : Text('Guest', style: AppTextStyles.heading),
            ),
            const SizedBox(height: 4),
            // Handle
            Center(
              child: state is AuthenticatedState
                  ? Text(
                      '@${state.user.githubUsername}',
                      style: AppTextStyles.body.copyWith(
                        color: AppPalette.outline,
                      ),
                    )
                  : Text(
                      '@guest',
                      style: AppTextStyles.body.copyWith(
                        color: AppPalette.outline,
                      ),
                    ),
            ),
            const SizedBox(height: 16),
            // Badges Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Badge 1: Workspace Admin
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppPalette.primaryFixed,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.workspace_premium,
                        size: 16,
                        color: AppPalette.primary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        state is AuthenticatedState
                            ? (state.user.ownOrganizations?.isNotEmpty ?? false)
                                  ? 'Workspace Admin'
                                  : "Workspace Member"
                            : "Guest",
                        style: AppTextStyles.caption.copyWith(
                          color: AppPalette.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                // Badge 2: Premium Plan
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppPalette.successContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 16,
                        color: AppPalette.onSuccessContainer,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Premium Plan',
                        style: AppTextStyles.caption.copyWith(
                          color: AppPalette.onSuccessContainer,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
