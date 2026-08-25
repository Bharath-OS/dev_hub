import 'package:dev_hub/features/membership/presentation/member%20invitation/pages/search_user_tile.dart';
import 'package:dev_hub/features/membership/presentation/member%20invitation/pages/selected_user_tile.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../bloc/membership_bloc.dart';
import '../../../domain/entity/invited_user_entity.dart';

/// Main Sheet Content Widget to be passed to your global bottom sheet
class InviteMemberSheet extends StatefulWidget {
  const InviteMemberSheet({super.key});

  @override
  State<InviteMemberSheet> createState() => _InviteMemberSheetState();
}

class _InviteMemberSheetState extends State<InviteMemberSheet> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  // List of members added to the invitation
  final List<InvitedUserEntity> _selectedUsers = [];

  // Current search state (Replace with BlocBuilder/BlocListener integration)
  MembershipState _currentSearchState = NoUsersFoundState();

  @override
  void initState() {
    super.initState();

    // Initial dummy selected users to match design image
    _selectedUsers.addAll([
      InvitedUserEntity(
        id: '1',
        username: 'arjunpatel',
        fullName: 'Arjun Patel',
        avatarUrl:
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?fit=crop&w=300&q=80',
        role: 'Developer',
      ),
      InvitedUserEntity(
        id: '2',
        username: 'arjunpatel',
        fullName: 'Arjun Patel',
        avatarUrl:
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?fit=crop&w=300&q=80',
        role: 'Team Lead',
      ),
    ]);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // Handle Search Input Change
  void _onSearchChanged(String query) {
    // TODO: Add your BLoC Event dispatch logic here:
    // context.read<UserSearchBloc>().add(SearchUsersEvent(query));

    setState(() {
      if (query.trim().isEmpty) {
        _currentSearchState = NoUsersFoundState();
      } else if (query.trim() == 'arjun') {
        _currentSearchState = UsersFoundState([
          InvitedUserEntity(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            username: 'arjunpatel',
            fullName: 'Arjun Patel',
            avatarUrl:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?fit=crop&w=300&q=80',
          ),
        ]);
      } else {
        _currentSearchState = SearchingUsersState();
      }
    });
  }

  // Add User to Selected List
  void _addUser(InvitedUserEntity user) {
    setState(() {
      _selectedUsers.add(user);
      _searchController.clear();
      _currentSearchState = NoUsersFoundState();
    });
  }

  // Remove User from Selected List
  void _removeUser(int index) {
    setState(() {
      _selectedUsers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.marginMobile,
        vertical: AppSpacing.md,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.outlineVariant,
                borderRadius: AppRadius.fullBorderRadius,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Header Title & Description
          _buildHeader(context),
          const SizedBox(height: AppSpacing.lg),

          // GitHub Search Field Section with Floating Pop-up / Overlay
          _buildSearchSection(),
          const SizedBox(height: AppSpacing.lg),

          // Selected Users List
          _buildSelectedUsersSection(),
          const SizedBox(height: AppSpacing.lg),

          // Optional Personal Message Text Field
          _buildMessageField(),
          const SizedBox(height: AppSpacing.xl),

          // Send Invite Primary Button
          _buildSendInviteButton(),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }

  /// Private function: Header layout
  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Invite Member',
              style: AppTextStyles.heading.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.onSurface,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close_rounded,
                color: AppColors.onSurfaceVariant,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Invite a developer to join this workspace.',
          style: AppTextStyles.body.copyWith(
            color: AppColors.secondary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  /// Private function: GitHub Search Field with Non-blocking Floating Popup Stack
  Widget _buildSearchSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'GitHub Username',
          style: AppTextStyles.caption.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Text Input Field
            SizedBox(
              height: AppHeights.inputHeight,
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.onSurface,
                ),
                decoration: InputDecoration(
                  hintText: 'arjun',
                  hintStyle: AppTextStyles.body.copyWith(
                    color: AppColors.onSurface,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(
                        left: AppSpacing.md, right: AppSpacing.xs),
                    child: Center(
                      widthFactor: 1.0,
                      child: Text(
                        '@',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.onSurfaceVariant,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.md,
                  ),
                  filled: true,
                  fillColor: AppColors.surfaceContainerLowest,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: AppRadius.mdBorderRadius,
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: AppRadius.mdBorderRadius,
                    borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                  ),
                ),
              ),
            ),

            // Pop-up Floating Overlay for Search Results
            if (_currentSearchState is! NoUsersFoundState)
              Positioned(
                top: AppHeights.inputHeight + 4,
                left: 0,
                right: 0,
                child: Material(
                  elevation: 6,
                  shadowColor: Colors.black12,
                  borderRadius: AppRadius.mdBorderRadius,
                  child: Container(
                    height: 200,
                    padding: const EdgeInsets.all(AppSpacing.xs),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLowest,
                      borderRadius: AppRadius.mdBorderRadius,
                      border: Border.all(color: AppColors.border),
                    ),
                    child: _buildSearchResultsContent(),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  /// Search Results popup inner content based on Bloc state
  Widget _buildSearchResultsContent() {
    if (_currentSearchState is SearchingUsersState) {
      return const Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.primary,
          ),
        ),
      );
    } else if (_currentSearchState is UsersFoundState) {
      final users = (_currentSearchState as UsersFoundState).users;
      return ListView.builder(
        shrinkWrap: true,
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return SearchUserTile(
            user: user,
            onAdd: () => _addUser(user),
          );
        },
      );
    }
    return const SizedBox.shrink();
  }

  /// Private function: Selected Users Section
  Widget _buildSelectedUsersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selected Users',
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.onSurface,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        if (_selectedUsers.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Text(
              'No users selected yet.',
              style: AppTextStyles.caption.copyWith(color: AppColors.outline),
            ),
          )
        else
          Column(
            children: List.generate(_selectedUsers.length, (index) {
              final user = _selectedUsers[index];
              return SelectedUserTile(
                user: user,
                onRoleChanged: (newRole) {
                  if (newRole != null) {
                    setState(() {
                      user.role = newRole;
                    });
                  }
                },
                onRemove: () => _removeUser(index),
              );
            }),
          ),
      ],
    );
  }

  /// Private function: Personal Message Input Field
  Widget _buildMessageField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Personal Message ',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.onSurface,
            ),
            children: [
              TextSpan(
                text: '(Optional)',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.secondary,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        TextField(
          controller: _messageController,
          maxLines: 3,
          maxLength: 120,
          onChanged: (text) {
            setState(() {});
          },
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.onSurface,
          ),
          decoration: InputDecoration(
            hintText: 'Add a personal message...',
            hintStyle: AppTextStyles.body.copyWith(
              color: AppColors.outline,
            ),
            contentPadding: const EdgeInsets.all(AppSpacing.md),
            filled: true,
            fillColor: AppColors.surfaceContainerLowest,
            enabledBorder: OutlineInputBorder(
              borderRadius: AppRadius.mdBorderRadius,
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppRadius.mdBorderRadius,
              borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
            ),
            counterStyle: AppTextStyles.caption.copyWith(
              color: AppColors.outline,
            ),
          ),
        ),
      ],
    );
  }

  /// Private function: Send Invite Action Button
  Widget _buildSendInviteButton() {
    return SizedBox(
      width: double.infinity,
      height: AppHeights.buttonHeight,
      child: ElevatedButton.icon(
        onPressed: () {
          // TODO: Add backend logic to dispatch send invitation request
          print('Send Invite Clicked!');
          print('Selected Users: ${_selectedUsers.map((u) => '${u.username} (${u.role})').toList()}');
          print('Message: ${_messageController.text}');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.primaryBorderRadius,
          ),
        ),
        icon: const Icon(
          Icons.send_rounded,
          size: 18,
          color: AppColors.onPrimary,
        ),
        label: Text(
          'Send Invite',
          style: AppTextStyles.button,
        ),
      ),
    );
  }
}