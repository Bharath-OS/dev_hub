import 'package:flutter/material.dart';

import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_text_styles.dart';

class DescriptionText extends StatelessWidget {
  const DescriptionText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Manage GitHub projects, communicate with your team, and track development progress from one place.',
      style: AppTextStyles.bodyMedium.copyWith(
        color: AppPalette.onSurfaceVariant,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Welcome to DevHub',
      style: AppTextStyles.heading.copyWith(
        color: AppPalette.onSurface,
        fontWeight: FontWeight.w700,
      ),
      textAlign: TextAlign.center,
    );
  }
}

// Private terms & privacy text component.
class TermsAndPrivacyText extends StatelessWidget {
  const TermsAndPrivacyText({super.key});

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

