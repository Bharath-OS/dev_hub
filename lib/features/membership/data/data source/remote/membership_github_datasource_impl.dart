import 'package:dev_hub/core/constants/api_endpoints.dart';
import 'package:dev_hub/core/params/api_params.dart';
import 'package:dev_hub/shared/data/datasources/local/token_manager.dart';
import 'package:dev_hub/shared/data/datasources/remote/api_client.dart';
import '../../../../../core/utils/api_response_validator.dart';
import '../../model/invited_user_model.dart';

abstract interface class MembershipGithubDatasource {
  Future<List<InvitedUserModel>> searchUserFromGitHub(String searchQuery);

  Future<bool> checkOrgMembershipStatus({
    required String orgName,
    required String userName,
  });

  Future<bool> sendOrgInvitation({
    int? userId,
    String? email,
    required String orgName,
    List<int>? teamIds,
  });

  Future<bool> giveRepoAccess({
    required String username,
    required String role,
    required String ownerName,
    required String repoName,
  });
}

class MembershipGithubDatasourceImpl implements MembershipGithubDatasource {
  final ApiClientInterface _apiClient;
  final TokenManager _tokenManager;
  final ApiEndpoints _apiEndpoints;
  MembershipGithubDatasourceImpl({
    required this._apiClient,
    required this._tokenManager,
    required this._apiEndpoints,
  });

  @override
  Future<List<InvitedUserModel>> searchUserFromGitHub(
    String searchQuery,
  ) async {
    final String? accessToken = await _tokenManager.getToken();
    try {
      if (accessToken == null) {
        throw Exception('Could not find a valid access token');
      }
      final params = ApiParams(
        accessToken: accessToken,
        endpoint: _apiEndpoints.searchUserEndpoint(userName: searchQuery),
      );

      final result = await _apiClient.get(params);

      return result.fold((failure) => throw Exception(failure.message), (
        response,
      ) {
        // Use the utility for standard 200/201 validation
        final validated = ApiResponseValidator.validate(response);

        return validated.fold((failure) => throw Exception(failure.message), (
          res,
        ) {
          final Map<String, dynamic> data = res.data as Map<String, dynamic>;
          return (data['items'] as List)
              .map(
                (user) =>
                    InvitedUserModel.fromMap(user as Map<String, dynamic>),
              )
              .toList();
        });
      });
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  @override
  Future<bool> checkOrgMembershipStatus({
    required String orgName,
    required String userName,
  }) async {
    try {
      final params = ApiParams(
        endpoint: _apiEndpoints.checkOrgMembershipStatusEndpoint(
          orgName: orgName,
          username: userName,
        ),
      );
      final result = await _apiClient.get(params);

      return result.fold((error) => throw (Exception(error.message)), (
        response,
      ) {
        // GitHub returns 204 if the user is a member, 404 if not.
        // Since we set validateStatus to true in DioClient, we handle these manually here.
        final apiResponse = ApiResponseValidator.validate(
          response,
          validCodes: [204, 404],
        );
        return apiResponse.fold((error) => throw error, (response) {
          if (response.statusCode == 204) return true;
          return false;
        });
      });
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<bool> sendOrgInvitation({
    int? userId,
    String? email,
    required String orgName,
    List<int>? teamIds,
  }) async {
    if (userId == null && email == null) {
      throw Exception(
        'Both userId and email is null. Please provide either of them to send the invitation.',
      );
    }
    final Map<String, dynamic> data = {};
    data[userId != null ? 'invitee_id' : 'email'] = (userId ?? email)!;
    data['role'] = 'direct_member';
    data['teams_ids'] = teamIds ?? [];
    final apiParams = ApiParams(
      endpoint: _apiEndpoints.sendOrgInvitationEndpoint(orgName: orgName),
      data: data,
    );

    final result = await _apiClient.post(apiParams);

    return result.fold(
      (failure) => throw failure,
      (response) => response.statusCode == 201,
    );
  }

  @override
  Future<bool> giveRepoAccess({
    required String username,
    required String role,
    required String ownerName,
    required String repoName,
  }) async {
    try {
      final Map<String, String> data = {'role': role};
      final params = ApiParams(
        endpoint: _apiEndpoints.giveRepositoryAccessEndpoint(
          ownerName: ownerName,
          username: username,
          repoName: repoName,
        ),
        data: data,
      );
      final result = await _apiClient.put(params);
      return result.fold((failure) => throw Exception(failure.message), (
        response,
      ) {
        return ApiResponseValidator.validate(
          response,
          validCodes: [201, 204],
        ).fold((failure) => throw failure, (success) {
          if (response.statusCode == 201) {
            return true;
          } else {
            return false;
          }
        });
      });
    } catch (e) {
      rethrow;
    }
  }
}
