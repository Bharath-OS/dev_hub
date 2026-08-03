import 'package:dev_hub/core/params/api_params.dart';
import 'package:fpdart/fpdart.dart';
import '../../../core/errors/failures.dart';
import '../../../presentation/auth/domain/entities/user_entity.dart';
import 'api_client.dart';

class GithubApiDataSource {
  final ApiClient _client;

  GithubApiDataSource({required ApiClient client}) : _client = client;

  Future<Either<Failure, List<GitHubOrgInfo>>> getOrganizations({
    required String githubUsername,
    required String accessToken,
  }) async {
    final organizationEndpoint = "/user/orgs";
    final params = ApiParams(
      accessToken: accessToken,
      endpoint: organizationEndpoint,
    );
    final result = await _client.get(params);

    return result.fold(
      (failure) => left(failure),
      (response) async {
        final List<dynamic> orgList = response is List ? response : [];
        if (orgList.isEmpty) return right([]);

        final List<GitHubOrgInfo> orgs = [];
        for (final org in orgList) {
          final orgName = org['login'].toString();
          final roleResult = await getUserRoleInOrg(
            orgName: orgName,
            githubUsername: githubUsername,
            accessToken: accessToken,
          );

          roleResult.fold(
            (_) => null, // Ignore failure for individual org role fetch or handle it
            (roleMap) {
              orgs.add(
                GitHubOrgInfo(
                  id: org['id'].toString(),
                  login: orgName,
                  avatarUrl: org['avatar_url'].toString(),
                  role: roleMap['role'],
                  state: roleMap['state'],
                ),
              );
            },
          );
        }
        return right(orgs);
      },
    );
  }

  Future<Either<Failure, Map<String, String>>> getUserRoleInOrg({
    required String orgName,
    required String githubUsername,
    required String accessToken,
  }) async {
    final membershipEndpoint = "/orgs/$orgName/memberships/$githubUsername";
    final result = await _client.get(
      ApiParams(accessToken: accessToken, endpoint: membershipEndpoint),
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        final Map<String, dynamic> roleMap =
            response is Map ? Map.from(response) : {};
        return right({
          'role': roleMap['role']?.toString() ?? '',
          'state': roleMap['state']?.toString() ?? '',
        });
      },
    );
  }

  Future<Either<Failure, void>> inviteMember({
    required String memberName,
    required String accessToken,
  }) async {
    // Implementation for invitation
    return left(Failure("Not implemented yet"));
  }
}
