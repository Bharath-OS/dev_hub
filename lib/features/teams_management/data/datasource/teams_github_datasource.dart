import 'package:dev_hub/core/constants/api_endpoints.dart';
import 'package:dev_hub/core/params/api_params.dart';
import 'package:dev_hub/features/teams_management/params/team_params.dart';
import 'package:dev_hub/shared/data/datasources/remote/api_client.dart';
import 'package:dio/dio.dart';

abstract interface class TeamsGitHubDataSource {
  Future<Response<dynamic>> createGitHubTeam({
    required String orgName,
    required TeamParams teamParams,
  });

  Future<Response<dynamic>> getAllTeams({required String orgName});

  Future<Response<dynamic>> getATeamByName({
    required String orgName,
    required String teamSlug,
  });

  Future<void> deleteTeam({required String orgName, required String teamSlug});

  Future<Response<dynamic>> modifyTeamDetails({
    required String orgName,
    required String teamSlug,
    required Map<String, dynamic> data,
  });
}

class TeamsGitHubDataSourceImpl implements TeamsGitHubDataSource {
  final ApiClientInterface _apiClient;
  final ApiEndpoints _endpoints;
  TeamsGitHubDataSourceImpl({
    required this._endpoints,
    required this._apiClient,
  });

  @override
  Future<Response<dynamic>> createGitHubTeam({
    required String orgName,
    required TeamParams teamParams,
  }) async {
    final data = <String, dynamic>{
      'name': teamParams.name,
      'description': teamParams.description ?? '',
      'repo_names': [teamParams.githubRepoFullName],
      'privacy': teamParams.privacy!.name,
      'notification_setting': 'notifications_enabled',
      'permission': teamParams.permission!.name,
    };
    final params = ApiParams(
      endpoint: _endpoints.createTeamEndpoint(orgName: orgName),
      data: data,
    );
    final apiResponse = await _apiClient.post(params);
    return apiResponse.fold((failure) => throw failure, (response) => response);
  }

  @override
  Future<Response<dynamic>> getAllTeams({required String orgName}) async {
    final params = ApiParams(
      endpoint: _endpoints.getAllTeamsInOrgEndpoint(orgName: orgName),
    );
    final response = await _apiClient.get(params);
    return response.fold(
      (failure) => throw failure,
      (responseObj) => responseObj,
    );
  }

  @override
  Future<Response<dynamic>> getATeamByName({
    required String orgName,
    required String teamSlug,
  }) async {
    final params = ApiParams(
      endpoint: _endpoints.getASpecificTeamEndpoint(
        orgName: orgName,
        teamSlug: teamSlug,
      ),
    );
    final response = await _apiClient.get(params);
    return response.fold(
      (failure) => throw failure,
      (apiResponse) => apiResponse,
    );
  }

  @override
  Future<void> deleteTeam({
    required String orgName,
    required String teamSlug,
  }) async {
    final params = ApiParams(
      endpoint: _endpoints.deleteATeamEndpoint(
        orgName: orgName,
        teamSlug: teamSlug,
      ),
    );
    final response = await _apiClient.delete(params);
    response.fold((failure) => throw failure, (_) {});
  }

  @override
  Future<Response<dynamic>> modifyTeamDetails({
    required String orgName,
    required String teamSlug,
    required Map<String, dynamic> data,
  }) async {
    final params = ApiParams(
      endpoint: _endpoints.updateTeamEndpoint(
        orgName: orgName,
        teamSlug: teamSlug,
      ),
      data: data,
    );
    final apiResponse = await _apiClient.patch(params);
    return apiResponse.fold((failure) => throw failure, (response) => response);
  }
}
