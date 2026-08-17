import 'package:dev_hub/shared/data/datasources/local/token_manager.dart';
import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  final TokenManager _tokenManager;
  ApiInterceptor(this._tokenManager);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Only add authorization if not already present
    if (!options.headers.containsKey('Authorization')) {
      final accessToken = await _tokenManager.getToken();
      if (accessToken != null && accessToken.isNotEmpty) {
        options.headers['Authorization'] = 'token $accessToken';
      }
    }
    return handler.next(options);
  }
}
