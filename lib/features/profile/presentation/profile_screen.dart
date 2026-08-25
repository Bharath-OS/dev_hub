import 'package:dev_hub/features/auth/presentation/pages/auth_screen.dart';
import 'package:dev_hub/features/profile/presentation/widgets/account_section.dart';
import 'package:dev_hub/features/profile/presentation/widgets/admin_section.dart';
import 'package:dev_hub/features/profile/presentation/widgets/current_organization_section.dart';
import 'package:dev_hub/features/profile/presentation/widgets/logout_section.dart';
import 'package:dev_hub/features/profile/presentation/widgets/profile_footer_section.dart';
import 'package:dev_hub/features/profile/presentation/widgets/profile_header_section.dart';
import 'package:dev_hub/features/profile/presentation/widgets/subscription_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../auth/presentation/bloc/auth_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if(state is AuthLogoutSuccess){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>AuthScreen()),(route)=>false);
          }
        },
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              // Responsive container
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    ProfileHeaderSection(),
                    SizedBox(height: 24),
                    CurrentOrganizationSection(),
                    SizedBox(height: 24),
                    AccountSection(),
                    SizedBox(height: 24),
                    AdminSection(),
                    SizedBox(height: 24),
                    SubscriptionSection(),
                    SizedBox(height: 24),
                    LogoutSection(),
                    SizedBox(height: 24),
                    ProfileFooterSection(),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}