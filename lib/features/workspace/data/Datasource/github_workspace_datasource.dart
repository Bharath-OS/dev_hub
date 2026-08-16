import 'package:dev_hub/core/params/api_params.dart';
import 'package:dev_hub/shared/data/datasources/remote/api_client.dart';
import '../model/repository_model.dart';

abstract interface class GithubWorkspaceDataSource {
  Future<List<RepositoryModel>> getRepositories({
    required String orgName,
    required String accessToken,
  });
}

class GithubWorkspaceDataSourceImpl implements GithubWorkspaceDataSource {
  final ApiClientInterface _apiClient;

  GithubWorkspaceDataSourceImpl(this._apiClient);

  @override
  Future<List<RepositoryModel>> getRepositories({
    required String orgName,
    required String accessToken,
  }) async {
    final endpoint = "/orgs/$orgName/repos";
    final params = ApiParams(
      accessToken: accessToken,
      endpoint: endpoint,
    );

    final result = await _apiClient.get(params);

    return result.fold(
      (failure) => throw failure,
      (response) {
        if (response is List) {
          return response
              .map((repo) => RepositoryModel.fromMap(repo as Map<String, dynamic>))
              .toList();
        }
        return [];
      },
    );
  }
}
