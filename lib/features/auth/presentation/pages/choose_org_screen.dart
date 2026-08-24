import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dev_hub/core/constants/app_colors.dart';
import 'package:dev_hub/core/constants/app_constants.dart';
import 'package:dev_hub/core/constants/app_text_styles.dart';
import '../../../../../main_screen.dart';
import '../../../../shared/presentation/widgets/primary_button.dart';
import '../../domain/entities/user_entity.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/choose_org_widgets/admin_success_illustration.dart';
import '../widgets/choose_org_widgets/choose_org_texts.dart';
import '../widgets/choose_org_widgets/org_dropdown_selector.dart';

class ChooseOrgScreen extends StatefulWidget {
  final UserEntity user;

  const ChooseOrgScreen({
    super.key,
    required this.user,
  });

  @override
  State<ChooseOrgScreen> createState() => _ChooseOrgScreenState();
}

class _ChooseOrgScreenState extends State<ChooseOrgScreen> {
  List<GitHubOrgInfo> _orgs = [];
  GitHubOrgInfo? _selectedOrg;
  bool _isDialogShowing = false;

  @override
  void initState() {
    super.initState();
    // Default to ownOrganizations, fallback to allOrganizations if empty
    _orgs = widget.user.ownOrganizations ?? [];
    if (_orgs.isEmpty) {
      _orgs = widget.user.allOrganizations ?? [];
    }

    if (_orgs.isNotEmpty) {
      _selectedOrg = _orgs.first;
    }
  }

  void _onGoToWorkspaces() {
    if (_selectedOrg == null) return;

    context.read<AuthBloc>().add(
      AuthUpdateOrganization(
        user: widget.user,
        selectedOrg: _selectedOrg!,
      ),
    );
  }

  void _showLoadingDialog() {
    if (_isDialogShowing) return;
    _isDialogShowing = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(color: AppPalette.primary),
      ),
    );
  }

  void _dismissLoadingDialog() {
    if (_isDialogShowing && mounted) {
      _isDialogShowing = false;
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthOrgUpdating) {
          _showLoadingDialog();
        } else if (state is AuthOrgUpdateSuccess) {
          _dismissLoadingDialog();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const MainClass()),
          );
        } else if (state is AuthOrgUpdateFailure) {
          _dismissLoadingDialog();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppPalette.error,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppPalette.background,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.marginMobile,
                vertical: AppSpacing.lg,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Crown and Shield success illustration
                  const AdminSuccessIllustration(),
                  const SizedBox(height: AppSpacing.md),

                  // Success Headers
                  const AdminSuccessTitleText(),
                  const SizedBox(height: AppSpacing.sm),
                  const ChooseOrgSubtitleText(),
                  const SizedBox(height: AppSpacing.md),

                  const Divider(color: AppPalette.border, height: 1),
                  const SizedBox(height: AppSpacing.md),

                  // Selection Section Header
                  const YourOrgsHeadingText(),
                  const SizedBox(height: AppSpacing.sm),

                  // Dropdown Selector or empty state message
                  if (_orgs.isNotEmpty) ...[
                    OrgDropdownSelector(
                      organizations: _orgs,
                      selectedOrg: _selectedOrg,
                      onChanged: (GitHubOrgInfo? org) {
                        setState(() {
                          _selectedOrg = org;
                        });
                      },
                    ),
                  ] else ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                      child: Text(
                        'No organizations available.',
                        style: AppTextStyles.body.copyWith(
                          color: AppPalette.outline,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.md),

                  // Info Tip Card
                  const TipCardWidget(),
                  const SizedBox(height: AppSpacing.xl),

                  // Submit / Navigate Button
                  PrimaryButton(
                    text: 'Go to Workspaces',
                    onPressed: _selectedOrg != null ? _onGoToWorkspaces : null,
                    icon: const Icon(
                      Icons.dashboard_customize_rounded,
                      color: AppPalette.onPrimary,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



