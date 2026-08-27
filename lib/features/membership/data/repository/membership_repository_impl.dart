import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/features/membership/data/data%20source/remote/membership_firestore_datasource.dart';
import 'package:dev_hub/features/membership/data/data%20source/remote/membership_github_datasource_impl.dart';
import 'package:dev_hub/features/membership/data/model/invitation_model.dart';
import 'package:dev_hub/features/membership/domain/entity/invitation_entity.dart';
import 'package:dev_hub/features/membership/domain/entity/invited_user_entity.dart';
import 'package:dev_hub/features/membership/domain/entity/member_entity.dart';
import 'package:dev_hub/features/membership/domain/repository/membership_repository.dart';
import 'package:dev_hub/features/membership/params/invitation_params.dart';
import 'package:fpdart/fpdart.dart';

class MembershipRepositoryImpl implements MembershipRepository {
  final MembershipGithubDatasource _gitHubApiService;
  final MembershipFirestoreDatasource _remoteDatabaseService;

  MembershipRepositoryImpl({
    required this._gitHubApiService,
    required this._remoteDatabaseService,
  });
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
  Future<Either<Failure, MemberEntity>> addRepositoryCollaborator(
    InvitationParams params,
  ) async {
    try {
      final didAdded = await _gitHubApiService.giveRepoAccess(
        username: params.userName!,
        role: params.repoRole!,
        ownerName: params.ownerName!,
        repoName: params.repoName!,
      );
      if (didAdded == null) {
        return left(
          Failure('${params.userName!} is already have repository access.'),
        );
      }
      final member = await _remoteDatabaseService.addMember(
        InvitationParams.toMemberModel(didAdded),
      );
      return right(member);
    } on Failure catch (failure) {
      return left(failure);
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
  Future<Either<Failure, InvitationEntity>> sendOrgInvitation(
    InvitationParams params,
  ) async {
    try {
      final githubInvitationResult = await _gitHubApiService.sendOrgInvitation(
        orgName: params.orgName!,
        inviteeId: params.inviteeId!,
        role: params.orgRole!,
      );
      if (githubInvitationResult == null) {
        return left(Failure('Couldn\'t send invitation'));
      }
      final response = await _remoteDatabaseService.createInvitation(
        InvitationParams.toInvitationModel(githubInvitationResult),
      );
      return right(response);
    } catch (error) {
      return left(Failure(error.toString()));
    }
  }
}
