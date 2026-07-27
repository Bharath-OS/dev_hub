import 'package:dev_hub/domain/entities/user_entity.dart';
import 'dio_impl.dart';

class GithubApiDataSource {
  final String userToken;
  final ApiServices _services;

  GithubApiDataSource({required this.userToken, required this._services});

  Future<List<GitHubOrgInfo>> getOrganizations(String githubUsername) async {
    final organizationEndpoint = "/user/orgs";
    print("[GithubApiDataSource] Fetching orgs from $organizationEndpoint");
    final response =
        await _services.get(endpoint: organizationEndpoint);
    print("[GithubApiDataSource] Raw response type: ${response.runtimeType}");
    print("[GithubApiDataSource] Raw response: $response");

    final List<dynamic> orgList = response is List ? response : [];
    print("[GithubApiDataSource] Parsed org count: ${orgList.length}");

    if (orgList.isNotEmpty) {
      final List<GitHubOrgInfo> orgs = [];
      for (final org in orgList) {
        print("[GithubApiDataSource] Processing org: $org");
        print("[GithubApiDataSource] org['id'] type: ${org['id'].runtimeType}, value: ${org['id']}");
        print("[GithubApiDataSource] org['login'] type: ${org['login'].runtimeType}, value: ${org['login']}");
        print("[GithubApiDataSource] org['avatar_url'] type: ${org['avatar_url'].runtimeType}, value: ${org['avatar_url']}");

        final orgUserRole = await getUserRoleInOrg(org['login'].toString(), githubUsername);
        print("[GithubApiDataSource] Role for ${org['login']}: $orgUserRole");

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
      print("[GithubApiDataSource] Returning ${orgs.length} orgs");
      return orgs;
    }
    return [];
  }

  Future<Map<String, String>> getUserRoleInOrg(
    String orgName,
    String githubUsername,
  ) async {
    final membershipEndpoint = "/orgs/$orgName/memberships/$githubUsername";
    print("[GithubApiDataSource] Fetching role from $membershipEndpoint");
    final response =
        await _services.get(endpoint: membershipEndpoint);
    print("[GithubApiDataSource] Role response: $response");

    final Map<String, dynamic> roleMap = response is Map ? Map.from(response) : {};
    return {
      'role': roleMap['role']?.toString() ?? '',
      'state': roleMap['state']?.toString() ?? '',
    };
  }


}
