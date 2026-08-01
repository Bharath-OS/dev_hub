import '../../../presentation/auth/domain/entities/user_entity.dart';
import 'dio_impl.dart';

class GithubApiDataSource {
  final ApiServices services;

  GithubApiDataSource({required this.services});

  Future<List<GitHubOrgInfo>> getOrganizations(String githubUsername) async {
    final organizationEndpoint = "/user/orgs";
    final response =
        await services.get(endpoint: organizationEndpoint);

    final List<dynamic> orgList = response is List ? response : [];

    if (orgList.isNotEmpty) {
      final List<GitHubOrgInfo> orgs = [];
      for (final org in orgList) {

        final orgUserRole = await getUserRoleInOrg(org['login'].toString(), githubUsername);

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
    print("[GithubApiDataSource] Fetching role from $membershipEndpoint");
    final response =
        await services.get(endpoint: membershipEndpoint);
    print("[GithubApiDataSource] Role response: $response");

    final Map<String, dynamic> roleMap = response is Map ? Map.from(response) : {};
    return {
      'role': roleMap['role']?.toString() ?? '',
      'state': roleMap['state']?.toString() ?? '',
    };
  }

  Future<void> inviteMember({required String memberName}) async{

  }

}
