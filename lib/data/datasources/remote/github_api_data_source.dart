import 'package:dev_hub/domain/entities/user_entity.dart';
import 'dio_impl.dart';

class GithubApiDataSource {
  final String userToken;
  final ApiServices _services;

  GithubApiDataSource({required this.userToken, required this._services});

  Future<List<GitHubOrgInfo>> getOrganizations(String githubUsername) async {
    final organizationEndpoint = "/user/orgs";
    final response =
        await _services.get(endpoint: organizationEndpoint) as List<dynamic>;
    if (response.isNotEmpty) {
      final List<GitHubOrgInfo> orgs = [];
      for (final org in response) {
        final orgUserRole = await getUserRoleInOrg(org['login'], githubUsername);
        orgs.add(
          GitHubOrgInfo(
            id: org['id'].toString(),
            login: org['login'].toString(),
            avatarUrl: org['avatar_url'].toString(),
            role: orgUserRole['role'],
            state: orgUserRole['state'],
          ),
        );
      }
      return orgs;
    }
    return [];
  }

  Future<Map<String, String>> getUserRoleInOrg(
    String orgName,
    String githubUsername,
  ) async {
    final membershipEndpoint = "/orgs/$orgName/memberships/$githubUsername";
    final response =
        await _services.get(endpoint: membershipEndpoint)
            as Map<String, dynamic>;
    return {'role': response['role'], 'state': response['state']};
  }


}
