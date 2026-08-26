import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/features/membership/data/data%20source/remote/membership_github_datasource_impl.dart';
import 'package:dev_hub/features/membership/domain/entity/invited_user_entity.dart';
import 'package:dev_hub/features/membership/domain/repository/membership_repository.dart';
import 'package:fpdart/fpdart.dart';

class MembershipRepositoryImpl implements MembershipRepository {
  final MembershipGithubDatasource _gitHubApiService;

  MembershipRepositoryImpl({required this._gitHubApiService});
  @override
  Future<Either<Failure, List<InvitedUserEntity>>> searchUser(
    String searchQuery,
  ) async {
    try {
      final response = await _gitHubApiService.searchUserFromGitHub(
        searchQuery,
      );
      return right(response);
    } catch (error) {
      return left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> inviteUser(String userId, String workspaceId) {
    // TODO: implement inviteUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> addRepositoryCollaborator({
    required String repoName,
    required String ownerName,
    required String userName,
    required String role,
  }) async {
    try {
      final didAdded = await _gitHubApiService.giveRepoAccess(
        username: userName,
        role: role,
        ownerName: ownerName,
        repoName: repoName,
      );
      return right(didAdded);
    } catch (error) {
      return left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> checkMembership({
    required String orgName,
    required String userName,
  }) async {
    try {
      final isMember = await _gitHubApiService.checkOrgMembershipStatus(
        orgName: orgName,
        userName: userName,
      );
      return right(isMember);
    } catch (error) {
      return left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> sendOrgInvitation({
    required String orgName,
    int? userId,
    String? email,
  }) async {
    try {
      final didSendInvitation = await _gitHubApiService.sendOrgInvitation(
        orgName: orgName,
        userId: userId,
        email: email,
      );
      return right(didSendInvitation);
    } catch (error) {
      return left(Failure(error.toString()));
    }
  }
}
