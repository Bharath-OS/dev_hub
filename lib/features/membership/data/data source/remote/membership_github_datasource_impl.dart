import 'package:dev_hub/core/constants/api_endpoints.dart';
import 'package:dev_hub/core/params/api_params.dart';
import 'package:dev_hub/shared/data/datasources/local/token_manager.dart';
import 'package:dev_hub/shared/data/datasources/remote/api_client.dart';
import '../../model/invited_user_model.dart';

abstract interface class MembershipGithubDatasource {
  Future<List<InvitedUserModel>> searchUserFromGitHub(String searchQuery);
}

class MembershipGithubDatasourceImpl implements MembershipGithubDatasource{
  final ApiClientInterface _apiClient;
  final TokenManager _tokenManager;
  final ApiEndpoints _apiEndpoints;
  MembershipGithubDatasourceImpl({required this._apiClient, required this._tokenManager,required this._apiEndpoints});

  @override
  Future<List<InvitedUserModel>> searchUserFromGitHub(String searchQuery) async {
    final String? accessToken = await _tokenManager.getToken();
    try{
      if(accessToken == null){
        throw Exception('Could not find a valid access token');
      }
      final params = ApiParams(accessToken: accessToken, endpoint: _apiEndpoints.searchUserEndpoint(userName: searchQuery));
      final List<InvitedUserModel> usersList = [];

      final response = await _apiClient.get(params);
      response.fold((error)=>throw Exception(error.message), (users){
        users = users as Map<String, dynamic>;
        for(Map<String, dynamic> user in (users['items'] as List)){
          usersList.add(InvitedUserModel.fromMap(user));
        }
      });
      return usersList;

    }catch(error){
      throw Exception(error.toString());
    }
  }

}