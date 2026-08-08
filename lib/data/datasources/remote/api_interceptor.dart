import 'package:dev_hub/presentation/auth/data/datasource/local/auth_local_database_interface.dart';
import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  final AuthLocalDatabaseInterface _localDB;
  ApiInterceptor(this._localDB);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Only add authorization if not already present
    if (!options.headers.containsKey('Authorization')) {
      final accessToken = await _localDB.getToken();
      if (accessToken != null && accessToken.isNotEmpty) {
        options.headers['Authorization'] = 'token $accessToken';
      }
    }
    return handler.next(options);
  }
}
