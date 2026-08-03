import 'package:dev_hub/core/constants/local_storage_keys.dart';
import 'package:dev_hub/data/datasources/local/local_db_contract.dart';
import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  final LocalDatabase _db;
  ApiInterceptor(this._db);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Only add authorization if not already present
    if (!options.headers.containsKey('Authorization')) {
      final accessToken = await _db.readData(Keys.accessTokenKey);
      if (accessToken != null && accessToken.isNotEmpty) {
        options.headers['Authorization'] = 'token $accessToken';
      }
    }
    return handler.next(options);
  }
}
