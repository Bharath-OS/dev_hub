import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/shared/data/datasources/local/token_manager.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../shared/data/datasources/remote/github_api_data_source.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repository/org_repository.dart';
import '../datasource/local/auth_local_database_impl.dart';
import '../datasource/remote/auth_remote_database_impl.dart';

class OrgRepositoryImpl implements OrgRepository {
  final GithubApiDataSource _githubApiDataSource;
  final TokenManager _tokenManager;
  final AuthRemoteDatabaseImpl _remoteDB;
  final AuthLocalDatabaseImpl _localDB;

  OrgRepositoryImpl({required this._githubApiDataSource,required this._tokenManager,required this._remoteDB, required this._localDB});

  @override
  Future<Either<Failure, UserEntity>> fetchOrganizations(
    UserEntity user,
  ) async {
    final String? token = await _tokenManager.getToken();

    if (token == null || token.isEmpty) {
      return left(Failure('GitHub access token not found'));
    }

    final result = await _githubApiDataSource.getOrganizations(
      githubUsername: user.githubUsername,
      accessToken: token
    );

    return result.fold((failure) => left(failure), (orgs) async {
      final ownOrgs = orgs
          .where((org) => org.role == 'admin' || org.role == 'owner')
          .toList();

      final updatedUser = user.copyWith(
        allOrganizations: orgs,
        ownOrganizations: ownOrgs,
      );

      // Persist the fetched organizations to the remote database
      try {
        await _remoteDB.updateUser(
          userId: user.id,
          fields: {
            'allOrganizations': orgs.map((e) => e.toMap()).toList(),
            'ownOrganizations': ownOrgs.map((e) => e.toMap()).toList(),
          },
        );
      } catch (e) {
        // We log the error but still return the updated user object as we have the data in memory
        print("[OrgRepository] Failed to persist orgs: $e");
      }

      //checks if the user is member, completes the authentication by setting the login flag to true.
      if(updatedUser.allOrganizations!.isNotEmpty && updatedUser.ownOrganizations!.isEmpty){
        await _localDB.setIsLoggedIn(value: true);
      }
      return right(updatedUser);
    });
  }

  @override
  Future<Either<Failure, UserEntity>> updateCurrentOrganization({
    required UserEntity user,
    required GitHubOrgInfo selectedOrg,
  }) async {
    try {
      final now = DateTime.now();

      await _remoteDB.updateUser(
        userId: user.id,
        fields: {
          'currentOrganizationId': selectedOrg.id,
          'currentOrganizationLogin': selectedOrg.login,
          'lastSeen': now.toIso8601String(),
        },
      );

      final updatedUser = user.copyWith(
        currentOrganizationId: selectedOrg.id,
        currentOrganizationLogin: selectedOrg.login,
        lastSeen: now,
      );

      //by choosing an organization, the user completes the authentication. So sets this flag to true.
      await _localDB.setIsLoggedIn(value: true);

      return right(updatedUser);
    } catch (e) {
      if (e is Failure) return left(e);
      return left(Failure('Failed to update organization: ${e.toString()}'));
    }
  }
}
