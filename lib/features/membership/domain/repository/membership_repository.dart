import 'package:dev_hub/features/membership/domain/entity/invited_user_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';

abstract interface class MembershipRepository {
  Future<Either<Failure, List<InvitedUserEntity>>> searchUser(
    String searchQuery,
  );

  Future<Either<Failure, void>> inviteUser(String userId, String workspaceId);

  Future<Either<Failure, bool>> checkMembership({required String orgName,required String userName});

  Future<Either<Failure, bool>> sendOrgInvitation({required String orgName, int? userId, String? email});

  Future<Either<Failure, bool>> addRepositoryCollaborator({required String role, required String repoName, required String ownerName, required String userName});

}
