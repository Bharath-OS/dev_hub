import 'package:dev_hub/core/constants/api_endpoints.dart';
import 'package:dev_hub/core/params/api_params.dart';
import 'package:dev_hub/features/auth/data/models/user_model.dart';
import 'package:dev_hub/shared/data/datasources/remote/api_client.dart';
import '../model/repository_model.dart';

abstract interface class GithubWorkspaceDataSource {
  Future<List<RepositoryModel>> getRepositories({
    required String orgName,
    required String accessToken,
  });

  Future<void> inviteMemberToWorkspace({
    String? username,
    String? email,
    required String accessToken,
    required String orgName,
    required String teamId,
  });

  Future<List<UserModel>> searchMember({
    required String username,
    required String accessToken,
  });
}

class GithubWorkspaceDataSourceImpl implements GithubWorkspaceDataSource {
  final ApiClientInterface _apiClient;
  final ApiEndpoints _apiEndpoints;

  GithubWorkspaceDataSourceImpl({
    required this._apiClient,
    required this._apiEndpoints,
  });

  @override
  Future<List<RepositoryModel>> getRepositories({
    required String orgName,
    required String accessToken,
  }) async {
    final endpoint = _apiEndpoints.getOrganizationRepositoriesEndpoint(
      orgName: orgName,
    );
    final params = ApiParams(accessToken: accessToken, endpoint: endpoint);

    final result = await _apiClient.get(params);

    return result.fold((failure) => throw failure, (response) {
      if (response is List) {
        return response
            .map(
              (repo) => RepositoryModel.fromMap(repo as Map<String, dynamic>),
            )
            .toList();
      }
      return [];
    });
  }

  @override
  Future<void> inviteMemberToWorkspace({
    String? username,
    String? email,
    required String accessToken,
    required String orgName,
    required String teamId,
  }) async {
    final String endpoint = '/orgs/$orgName/invitations';
    final Map<String, dynamic> data = {};
    data[username != null ? 'invitee_id' : 'email'] = (username ?? email)!;
    data['role'] = 'direct_member';
    data['teams_ids'] = [teamId];

    final apiParams = ApiParams(
      accessToken: accessToken,
      endpoint: endpoint,
      data: data,
    );
    final result = await _apiClient.post(apiParams);

    return result.fold((failure) => throw failure, (success) {});
  }

  @override
  Future<List<UserModel>> searchMember({
    required String username,
    required String accessToken,
  }) async {
    final String endpoint = _apiEndpoints.searchUserEndpoint(
      userName: username,
    );
    final apiParams = ApiParams(accessToken: accessToken, endpoint: endpoint);

    final result = await _apiClient.get(apiParams);
    return result.fold((failure) => throw failure, (result) {
      return (result['items'] as List)
          .map((user) => UserModel.fromMap(user as Map<String, dynamic>))
          .toList();
    });
  }
}
