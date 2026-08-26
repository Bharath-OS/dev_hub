import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/features/membership/domain/repository/membership_repository.dart';
import 'package:dev_hub/features/membership/params/invitation_params.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/usecases/usecase.dart';

class InviteMemberToWorkspaceUseCase
    implements UseCase<bool, InvitationParams> {
  final MembershipRepository _repository;
  InviteMemberToWorkspaceUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(InvitationParams params) async {
    final checkMemberResult = await _repository.checkMembership(
      orgName: params.orgName!,
      userName: params.userName!,
    );
    final bool isMember = checkMemberResult.fold(
      (failure) => throw (Exception(failure.message)),
      (result) => result,
    );

    if (!isMember) {
      final sendOrgInviteResult = await _repository.sendOrgInvitation(
        orgName: params.orgName!,
      );
      final bool isSendOrgInvitation = sendOrgInviteResult.fold(
        (failure) => throw (Exception(failure.message)),
        (isSuccess) => isSuccess,
      );
      return right(isSendOrgInvitation);
    }
    final addRepoCollaboratorResult = await _repository
        .addRepositoryCollaborator(
          repoName: params.repoName!,
          ownerName: params.ownerName!,
          userName: params.userName!,
          role: params.role!,
        );
    final bool didMadeCollaborator = addRepoCollaboratorResult.fold(
      (failure) => throw (Exception(failure.message)),
      (isSuccess) => isSuccess,
    );

    //returns if we made the user a collaborator.
    return right(didMadeCollaborator);
  }
}
