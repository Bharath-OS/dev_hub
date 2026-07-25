import 'package:dio/dio.dart';
import 'dio_impl.dart';

class GithubApiDataSource {
  final String userToken;
  final ApiServices _services;

  GithubApiDataSource({required this.userToken,required this._services});

  Future<String> getOrganizationList() async{
    final response = await _services.get(endpoint: endpoint)
  }

  Future<String> getUserRoleInOrg(String orgName, String userToken) async {return '';}
}