import 'package:dev_hub/presentation/user_profile/presentation/widgets/account_section.dart';
import 'package:dev_hub/presentation/user_profile/presentation/widgets/admin_section.dart';
import 'package:dev_hub/presentation/user_profile/presentation/widgets/current_organization_section.dart';
import 'package:dev_hub/presentation/user_profile/presentation/widgets/logout_section.dart';
import 'package:dev_hub/presentation/user_profile/presentation/widgets/profile_footer_section.dart';
import 'package:dev_hub/presentation/user_profile/presentation/widgets/profile_header_section.dart';
import 'package:dev_hub/presentation/user_profile/presentation/widgets/subscription_section.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.bgColor,
      appBar: AppBar(
        title: const Text('DevHub'),
        centerTitle: true,
        backgroundColor: AppPalette.surfaceContainerLowest,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600), // Responsive container
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
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
    );
  }
}