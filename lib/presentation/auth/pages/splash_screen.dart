import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../workspace/pages/workspace.dart';
import 'choose_org_screen.dart';
import 'member_only_screen.dart';
import 'no_organization_screen.dart';
import 'auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  void _checkAuthAndNavigate() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    context.read<AuthBloc>().add(AuthCheckSession());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.primary,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSessionNotFound) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => AuthScreen()),
            );
          } else if (state is AuthSessionRestored) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const WorkspacePage()),
            );
          } else if (state is AuthSuccess) {
            context.read<AuthBloc>().add(AuthOrgVerification(state.user));
          } else if (state is AuthOrgAdminSuccess) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => ChooseOrgScreen(user: state.user),
              ),
            );
          } else if (state is AuthNoOrganization) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => NoOrganizationScreen(user: state.user),
              ),
            );
          } else if (state is AuthMemberOnly) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => MemberOnlyScreen(user: state.user),
              ),
            );
          } else if (state is AuthFailure || state is AuthOrgError) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const AuthScreen()),
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                child: Image.asset('assets/app_icon/app_logo.png'),
              ),
              SizedBox(
                width: 150,
                child: LinearProgressIndicator(
                  color: AppPalette.white,
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
