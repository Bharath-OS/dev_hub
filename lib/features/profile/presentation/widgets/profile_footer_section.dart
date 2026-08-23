import 'package:dev_hub/core/utils/format_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

class ProfileFooterSection extends StatelessWidget {
  const ProfileFooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<AuthBloc>().state;
    final String accountCreatedDate = state is AuthenticatedState
        ? FormatDate.formatDateByDayMonthYear(state.user.createdAt)
        : "";
    return Center(
      child: Text(
        'Member since $accountCreatedDate',
        style: AppTextStyles.caption.copyWith(color: AppPalette.outline),
      ),
    );
  }
}
