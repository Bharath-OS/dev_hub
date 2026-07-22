import 'package:dev_hub/core/constants/app_colors.dart';
import 'package:dev_hub/domain/repository/auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 200,
                        height: 180,
                        decoration: BoxDecoration(
                          color: AppPalette.gradientColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(300),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      alignment: Alignment.bottomCenter,
                      height: 200,
                      decoration: BoxDecoration(gradient: AppPalette.gradient),
                    ),
                  ],
                ),
              ),
              // Spacer(),
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppPalette.neutral.withAlpha(100),
                          blurRadius: 15,
                          offset: Offset(0, 12),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(20),
                      child: Image.asset(
                        "assets/app_icon/app_logo.png",
                        width: 80,
                      ),
                    ),
                  ),
                  SizedBox(height: 28),
                  Text(
                    'Welcome to DevHub',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppPalette.headingTextColor,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    textAlign: TextAlign.center,
                    'Manage GitHub projects,\ncommunicate with your team, \nand track development progress from \none place.',
                    style: subTextStyle(),
                  ),
                  SizedBox(height: 24),
                  Image.asset('assets/background_images/sign_in_bg_image.png'),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () async {
                      context.read<AuthBloc>().add(AuthSignUp());
                      final result = context.read<AuthBloc>().state;
                      if(result is AuthSuccess){
                        final uid = result.userCredential.user?.uid;
                        final name = result.userCredential.user?.displayName;
                        final email = result.userCredential.user!.email;
                        final photoURL = result.userCredential.user!.photoURL;
                        final refreshToken = result.userCredential.user!.refreshToken;
                        print("Here is the user id: $uid\nHere is the username: $name\n$email\n$photoURL\n$refreshToken");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppPalette.primary,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 10,
                      children: [
                        Image.asset(
                          "assets/app_icon/github_logo.png",
                          width: 24,
                          height: 24,
                        ),
                        Text(
                          'Continue With GitHub',
                          style: subTextStyle(AppPalette.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 28),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "By continuing you agree to our \n",
                      style: TextStyle(fontSize: 13, color: AppPalette.neutral),
                      children: [
                        TextSpan(
                          text: "Terms and Privacy Policy.",
                          style: TextStyle(
                            color: AppPalette.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle subTextStyle([Color color = AppPalette.mutedTextColor]) =>
      TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.w500);
}
