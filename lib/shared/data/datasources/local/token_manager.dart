import 'package:dev_hub/core/constants/local_storage_keys.dart';
import 'package:dev_hub/core/params/secure_storage_params.dart';
import 'package:dev_hub/shared/data/datasources/database_interface.dart';

class TokenManager {
  final DatabaseInterface _localDatabaseService;
  final LocalStorageKeys _keys;
  TokenManager({required this._localDatabaseService, required this._keys});

  Future<String?> getToken() async {
    final token = await _localDatabaseService.read(
      SecureStorageParams(key: _keys.accessTokenKey),
    );
    return token;
  }

  Future<void> setToken(String accessToken) async {
    await _localDatabaseService.create(
      SecureStorageParams(key: _keys.accessTokenKey, value: accessToken),
    );
  }

  Future<void> clearToken() async {
    await _localDatabaseService.delete(
      SecureStorageParams(key: _keys.accessTokenKey),
    );
  }

  Future<void> updateToken(String newAccessToken) async {
    await _localDatabaseService.update(
      SecureStorageParams(key: _keys.accessTokenKey, value: newAccessToken),
    );
  }
}
