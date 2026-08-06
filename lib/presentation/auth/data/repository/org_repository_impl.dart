import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/data/datasources/remote/github_api_data_source.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repository/org_repository.dart';
import '../datasource/remote/auth_remote_datasource.dart';

class OrgRepositoryImpl implements OrgRepository {
  final GithubApiDataSource _githubApiDataSource;
  final AuthRemoteDatabaseImpl _remoteDB;

  OrgRepositoryImpl(this._githubApiDataSource, this._remoteDB);

  @override
  Future<Either<Failure, UserEntity>> fetchOrganizations(
    UserEntity user,
  ) async {
    final token = user.githubAccessToken;

    if (token == null || token.isEmpty) {
      return left(Failure('GitHub access token not found'));
    }

    final result = await _githubApiDataSource.getOrganizations(
      githubUsername: user.githubUsername,
      accessToken: token,
    );

    return result.fold((failure) => left(failure), (orgs) {
      final ownOrgs = orgs
          .where((org) => org.role == 'admin' || org.role == 'owner')
          .toList();

      return right(
        user.copyWith(allOrganizations: orgs, ownOrganizations: ownOrgs),
      );
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

      return right(updatedUser);
    } catch (e) {
      return left(Failure('Failed to update organization: ${e.toString()}'));
    }
  }
}
