import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../widgets/app_logo_header.dart';
import '../../widgets/primary_button.dart';
import '../workspace/workspace.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late AnimationController _bgAnimationController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _bgAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(
        parent: _bgAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _bgAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.background,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Successfully authenticated!'),
                backgroundColor: AppPalette.success,
              ),
            );
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const WorkspacePage(),
              ),
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppPalette.error,
              ),
            );
          }
        },
        child: Stack(
          children: [
            // Dynamic subtle animated background elements
            _BackgroundDecoration(pulseAnimation: _pulseAnimation),

            // Main Content Area
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.marginMobile,
                    vertical: AppSpacing.lg,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const AppLogoHeader(size: 84),
                      const SizedBox(height: AppSpacing.lg),

                      Text(
                        'Welcome to DevHub',
                        style: AppTextStyles.heading.copyWith(
                          color: AppPalette.onSurface,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.sm),

                      Text(
                        'Manage GitHub projects, communicate with your team, and track development progress from one place.',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppPalette.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.xl),

                      Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: AppPalette.surfaceContainerLowest,
                          borderRadius: AppRadius.primaryBorderRadius,
                          border: Border.all(color: AppPalette.border),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppRadius.md),
                          child: Image.asset(
                            'assets/background_images/sign_in_bg_image.png',
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                              Icons.developer_mode_rounded,
                              size: 120,
                              color: AppPalette.primaryContainer,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxl),

                      // Authentication Action Button
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          final isLoading = state is AuthLoading;
                          return PrimaryButton(
                            text: 'Continue with GitHub',
                            isLoading: isLoading,
                            onPressed: () {
                              context.read<AuthBloc>().add(AuthSignUp());
                            },
                            icon: Image.asset(
                              'assets/app_icon/github_logo.png',
                              width: 22,
                              height: 22,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                Icons.code,
                                size: 22,
                                color: AppPalette.onPrimary,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      const _TermsAndPrivacyText(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackgroundDecoration extends StatelessWidget {
  final Animation<double> pulseAnimation;

  const _BackgroundDecoration({required this.pulseAnimation});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -150,
          right: -150,
          child: AnimatedBuilder(
            animation: pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: pulseAnimation.value,
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppPalette.gradientColor
                  ),
                ),
              );
            },
          ),
        ),

        // Bottom-left subtle surface container wave shape
        Positioned(
          bottom: -150,
          left: -80,
          child: Container(
            width: 200,
            height: 320,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppPalette.gradientColor,
            ),
          ),
        ),
      ],
    );
  }
}

/// Private terms & privacy text component.
class _TermsAndPrivacyText extends StatelessWidget {
  const _TermsAndPrivacyText();

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'By continuing you agree to our\n',
        style: AppTextStyles.caption.copyWith(
          color: AppPalette.onSurfaceVariant,
        ),
        children: const [
          TextSpan(
            text: 'Terms and Privacy Policy.',
            style: TextStyle(
              color: AppPalette.primaryContainer,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}
