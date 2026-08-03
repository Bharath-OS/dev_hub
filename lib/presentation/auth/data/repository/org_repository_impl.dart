import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/data/datasources/remote/dio_impl.dart';
import 'package:dev_hub/data/datasources/remote/github_api_data_source.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repository/org_repository.dart';

class OrgRepositoryImpl implements OrgRepository {
  final GithubApiDataSource _githubApiDataSource;

  OrgRepositoryImpl(this._githubApiDataSource);

  @override
  Future<Either<Failure, UserEntity>> fetchOrganizations(UserEntity user) async {
    final token = user.githubAccessToken;

    if (token == null || token.isEmpty) {
      return left(Failure('GitHub access token not found'));
    }

    final result = await _githubApiDataSource.getOrganizations(
      githubUsername: user.githubUsername,
      accessToken: token,
    );

    return result.fold(
      (failure) => left(failure),
      (orgs) {
        final ownOrgs = orgs
            .where((org) => org.role == 'admin' || org.role == 'owner')
            .toList();

        return right(user.copyWith(
          allOrganizations: orgs,
          ownOrganizations: ownOrgs,
        ));
      },
    );
  }
}
