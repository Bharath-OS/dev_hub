import 'package:dev_hub/core/constants/api_endpoints.dart';
import 'package:dev_hub/core/params/api_params.dart';
import 'package:dev_hub/features/auth/data/models/user_model.dart';
import 'package:dev_hub/shared/data/datasources/remote/api_client.dart';
import '../../../../core/utils/api_response_validator.dart';
import '../model/repository_model.dart';

abstract interface class GithubWorkspaceDataSource {
  Future<List<RepositoryModel>> getRepositories({
    required String orgName,
    required String accessToken,
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

    return result.fold(
      (failure) => throw failure,
      (response) {
        final validated = ApiResponseValidator.validate(response);
        return validated.fold(
          (failure) => throw failure,
          (res) {
            if (res.data is List) {
              return (res.data as List)
                  .map((repo) => RepositoryModel.fromMap(repo as Map<String, dynamic>))
                  .toList();
            }
            return [];
          },
        );
      },
    );
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
    
    return result.fold(
      (failure) => throw failure,
      (response) {
        final validated = ApiResponseValidator.validate(response);
        return validated.fold(
          (failure) => throw failure,
          (res) {
            return (res.data['items'] as List)
                .map((user) => UserModel.fromMap(user as Map<String, dynamic>))
                .toList();
          },
        );
      },
    );
  }
}
