import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../shared/presentation/widgets/app_logo_header.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/register_screen_widgets/app_logo.dart';
import '../widgets/register_screen_widgets/authentication_button.dart';
import '../widgets/register_screen_widgets/background_decoration.dart';
import '../widgets/register_screen_widgets/register_screen_texts.dart';
import 'choose_org_screen.dart';
import 'member_only_screen.dart';
import 'no_organization_screen.dart';

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
            context.read<AuthBloc>().add(AuthOrgVerification(state.user));
          } else if (state is AuthOrgAdminSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Organization verified successfully!'),
                backgroundColor: AppPalette.success,
              ),
            );
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => ChooseOrgScreen(user: state.user),
              ),
            );
          } else if (state is AuthNoOrganization) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NoOrganizationScreen(user: state.user),
              ),
            );
          } else if (state is AuthMemberOnly) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MemberOnlyScreen(user: state.user),
              ),
            );
          } else if (state is AuthOrgError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppPalette.error,
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
            BackgroundDecoration(pulseAnimation: _pulseAnimation),

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

                      WelcomeText(),
                      const SizedBox(height: AppSpacing.sm),

                      DescriptionText(),
                      const SizedBox(height: AppSpacing.xl),

                      AppLogoContainer(),
                      const SizedBox(height: AppSpacing.xxl),

                      // Authentication Action Button
                      AuthenticationButton(),
                      const SizedBox(height: AppSpacing.lg),

                      const TermsAndPrivacyText(),
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
