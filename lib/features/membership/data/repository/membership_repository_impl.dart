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
    try{
      final response = await _gitHubApiService.searchUserFromGitHub(searchQuery);
      return right(response);
    }catch(error){
      return left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> inviteUser(String userId, String workspaceId) {
    // TODO: implement inviteUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> addRepositoryCollaborator({required String repoName, required String ownerName, required String userName}) {
    // TODO: implement addRepositoryCollaborator
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> checkMembership() {
    // TODO: implement checkMembership
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> sendOrgInvitation({required String orgName, String? userId, String? email}) {
    // TODO: implement sendOrgInvitation
    throw UnimplementedError();
  }
}
