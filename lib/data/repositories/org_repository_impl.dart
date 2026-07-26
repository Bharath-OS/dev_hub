import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/data/datasources/remote/dio_impl.dart';
import 'package:dev_hub/data/datasources/remote/github_api_data_source.dart';
import 'package:dev_hub/domain/entities/user_entity.dart';
import 'package:dev_hub/domain/repository/org/org_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class OrgRepositoryImpl implements OrgRepository {
  @override
  Future<Either<Failures, UserEntity>> fetchOrganizations(UserEntity user) async {
    try {
      final token = user.githubAccessToken;
      if (token == null || token.isEmpty) {
        return left(const Failures('GitHub access token not found'));
      }

      final dio = Dio();
      final apiServices = ApiServices(dio, token);
      final githubApiDataSource = GithubApiDataSource(
        userToken: token,
        _services: apiServices,
      );

      final orgs = await githubApiDataSource.getOrganizations(user.githubUsername);
      final ownOrgs = orgs
          .where((org) => org.role == 'admin' || org.role == 'owner')
          .toList();

      return right(user.copyWith(
        allOrganizations: orgs,
        ownOrganizations: ownOrgs,
      ));
    } catch (e) {
      return left(Failures(e.toString()));
    }
  }
}
