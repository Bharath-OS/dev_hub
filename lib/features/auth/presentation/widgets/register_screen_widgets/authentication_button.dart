import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../shared/presentation/widgets/primary_button.dart';
import '../../bloc/auth_bloc.dart';

class AuthenticationButton extends StatelessWidget {
  const AuthenticationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final isLoading = state is AuthLoading || state is AuthOrgVerifying;
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
              color: AppColors.onPrimary,
            ),
          ),
        );
      },
    );
  }
}
