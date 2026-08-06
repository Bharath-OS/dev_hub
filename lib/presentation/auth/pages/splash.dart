import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../bloc/auth/auth_bloc.dart';
import 'choose_org_screen.dart';
import 'member_only_screen.dart';
import 'no_organization_screen.dart';
import 'register.dart';


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

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const AuthScreen()),
      );
    } else {
      context.read<AuthBloc>().add(AuthSignUp());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.primaryContainer,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
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
          child: SizedBox(
            width: 150,
            child: Image.asset('assets/app_icon/app_logo.png'),
          ),
        ),
      ),
    );
  }
}
