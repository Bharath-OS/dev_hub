import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/features/membership/domain/entity/invite_member_result.dart';
import 'package:dev_hub/features/membership/domain/repository/membership_repository.dart';
import 'package:dev_hub/features/membership/params/invitation_params.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/usecases/usecase.dart';

class InviteMemberToWorkspaceUseCase
    implements UseCase<InviteMemberResult, InvitationParams> {
  final MembershipRepository _repository;
  InviteMemberToWorkspaceUseCase(this._repository);

  @override
  Future<Either<Failure, InviteMemberResult>> call(
    InvitationParams params,
  ) async {
    final checkMemberResult = await _repository.checkMembership(
      orgName: params.orgName!,
      userName: params.userName!,
    );
    return checkMemberResult.fold((failure) => left(failure), (isMember) async {
      if (!isMember) {
        //here have to add the user id or user email.
        final invitationResult = await _repository.sendOrgInvitation(params);
        return invitationResult.fold(
          (failure) => left(failure),
          (invitation) => right(InvitationSentSuccess(invitation)),
        );
      }
      final accessResult = await _repository.addRepositoryCollaborator(params);
      return accessResult.fold((failure) => left(failure), (member) {
        return right(MemberAddedSuccess(member));
      });
    });
  }
}
