import 'dart:convert';

import 'package:dio/dio.dart';

class ApiServices {
  final Dio _dio;
  final String _githubToken;
  final String _baseURL = "https://api.github.com/";

  ApiServices(this._dio, this._githubToken) {
    _configureDio();
  }

  Future<dynamic> get({
    required String endpoint,
    Map<String, String> params = const {},
  }) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: params);
      if (response.statusCode == 200) {
        return jsonDecode(response.data);
      }
      throw Exception(response.statusMessage);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void _configureDio() {
    _dio.options.baseUrl = _baseURL;
    _dio.options.connectTimeout = Duration(seconds: 5);
    _dio.options.receiveTimeout = Duration(seconds: 3);
    _dio.options.headers = {"Authorization": "token $_githubToken"};
  }
}
