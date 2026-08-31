import 'package:dev_hub/core/constants/org_roles.dart';
import 'package:dev_hub/features/membership/domain/entity/invitation_entity.dart';
import 'package:dev_hub/features/membership/domain/entity/invite_member_result.dart';
import 'package:dev_hub/features/membership/domain/usecases/invite_member_to_workspace_usecase.dart';
import 'package:dev_hub/features/membership/domain/usecases/search_users_usecase.dart';
import 'package:dev_hub/features/membership/params/invitation_params.dart';
import 'package:dev_hub/features/workspace/domain/entity/workspace_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dev_hub/features/membership/domain/entity/invited_user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../domain/entity/invtee_invite_result.dart';

part 'membership_event.dart';
part 'membership_state.dart';

class MembershipBloc extends Bloc<MembershipEvent, MembershipState> {
  final SearchUsersUseCase _searchUsersUseCase;
  final InviteMemberToWorkspaceUseCase _inviteMemberToWorkspaceUseCase;

  MembershipBloc({
    required this._searchUsersUseCase,
    required this._inviteMemberToWorkspaceUseCase,
  }) : super(MembershipInitial()) {
    on<SearchUserEvent>((event, emit) async {
      emit(SearchingUsersState());
      final result = await _searchUsersUseCase.call(event.searchQuery);
      result.fold(
        (error) => emit(SearchFailureState(error.message)),
        (usersList) => usersList.isNotEmpty
            ? emit(UsersFoundState(usersList))
            : emit(NoUsersFoundState()),
      );
    });

    on<InviteMembersEvent>((event, emit) async {
      emit(InvitingMembersState());
      //for storing the invitation results for handling multiple invitations as a batch.
      final results = <InviteeInviteResult>[];

      for (final user in event.invitees) {
        final result = await _inviteMemberToWorkspaceUseCase.call(
          InvitationParams(
            inviteeId: user.inviteeId,
            repoRole: user.role,
            workspaceId: event.workspace.id,
            repoName: event.workspace.repositoryName,
            orgName: event.workspace.githubOrgLogin,
            ownerName: event.workspace.githubOrgLogin,
            userName: user.username,
          ),
        );
        result.fold(
          (failure) {
            print(failure.message);
            results.add(
              InviteeInviteResult(
                username: user.username,
                success: false,
                message: failure.message,
              ),
            );
          },
          (invitation) {
            results.add(
              InviteeInviteResult(
                username: user.username,
                success: true,
                message: invitation is MemberAddedSuccess
                    ? "Member added."
                    : "Invitation sent.",
              ),
            );
          },
        );
        final successCount = results.where((r) => r.success).length;
        final failureCount = results.length - successCount;
        if (successCount == 0) {
          emit(InviteFailureState('All of the invitations failed.'));
          return;
        }
        emit(
          InviteMemberSuccess(
            results: results,
            successCount: successCount,
            failureCount: failureCount,
          ),
        );
      }
    });
  }
}
