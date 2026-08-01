import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/data/datasources/remote/dio_impl.dart';
import 'package:dev_hub/data/datasources/remote/github_api_data_source.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repository/org_repository.dart';

class OrgRepositoryImpl implements OrgRepository {
  @override
  Future<Either<Failure, UserEntity>> fetchOrganizations(UserEntity user) async {
    try {
      final token = user.githubAccessToken;
      print("[OrgRepository] Token present: ${token != null && token.isNotEmpty}");
      print("[OrgRepository] GitHub username: ${user.githubUsername}");

      if (token == null || token.isEmpty) {
        return left(Failure('GitHub access token not found'));
      }

      final dio = Dio();
      final apiServices = ApiServices(dio, token);
      final githubApiDataSource = GithubApiDataSource(
        userToken: token,
        services: apiServices,
      );

      final orgs = await githubApiDataSource.getOrganizations(user.githubUsername);
      print("[OrgRepository] Fetched ${orgs.length} orgs");
      for (final org in orgs) {
        print("[OrgRepository] Org: ${org.login}, role: ${org.role}, state: ${org.state}");
      }

      final ownOrgs = orgs
          .where((org) => org.role == 'admin' || org.role == 'owner')
          .toList();
      print("[OrgRepository] Admin/owner orgs: ${ownOrgs.length}");

      return right(user.copyWith(
        allOrganizations: orgs,
        ownOrganizations: ownOrgs,
      ));
    } catch (e, stackTrace) {
      print("[OrgRepository] ERROR: $e");
      print("[OrgRepository] STACK TRACE: $stackTrace");
      return left(Failure(e.toString()));
    }
  }
}
