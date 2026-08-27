import 'package:dev_hub/features/membership/domain/entity/invitation_entity.dart';
import 'package:dev_hub/features/membership/domain/entity/invited_user_entity.dart';
import 'package:dev_hub/features/membership/domain/entity/member_entity.dart';
import 'package:dev_hub/features/membership/params/invitation_params.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';

abstract interface class MembershipRepository {
  Future<Either<Failure, List<InvitedUserEntity>>> searchUser(
    String searchQuery,
  );

  Future<Either<Failure, void>> inviteUser(String userId, String workspaceId);

  Future<Either<Failure, bool>> checkMembership({required String orgName,required String userName});

  Future<Either<Failure, InvitationEntity>> sendOrgInvitation(InvitationParams params);

  Future<Either<Failure, MemberEntity>> addRepositoryCollaborator(InvitationParams params);

}
