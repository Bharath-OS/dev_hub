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
    return checkMemberResult.fold((failure) => left(failure), (isMember) async {
      if (!isMember) {
        //here have to add the user id or user email.
        final sendOrgInviteResult = await _repository.sendOrgInvitation(
          orgName: params.orgName!,
        );
        return sendOrgInviteResult.fold(
          (failure) => left(failure),
          (didSendOrgInvitation) => right(didSendOrgInvitation),
        );
      }
      final addRepoCollaboratorResult = await _repository
          .addRepositoryCollaborator(
            repoName: params.repoName!,
            ownerName: params.ownerName!,
            userName: params.userName!,
            role: params.role!,
          );
      return addRepoCollaboratorResult.fold(
        (failure) => left(failure),
        (isSuccess) {
          return right(isSuccess);
        },
      );
    });
  }
}
