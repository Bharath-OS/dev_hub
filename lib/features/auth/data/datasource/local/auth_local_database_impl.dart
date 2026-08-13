import 'package:dev_hub/core/constants/local_storage_keys.dart';
import 'package:dev_hub/core/params/secure_storage_params.dart';
import '../../../../../shared/data/datasources/database_interface.dart';
import 'auth_local_database_interface.dart';

class AuthLocalDatabaseImpl implements AuthLocalDatabaseInterface {
  final DatabaseInterface _db;
  final LocalStorageKeys _keys;
  AuthLocalDatabaseImpl({required this._db, required this._keys});

  @override
  Future<void> storeUserToken({required String userToken}) async {
    final params = SecureStorageParams(
      key: _keys.accessTokenKey,
      value: userToken,
    );
    await _db.create(params);
  }

  @override
  Future<String?> getToken() async {
    return await _db.read(SecureStorageParams(key: _keys.accessTokenKey));
  }

  @override
  Future<bool> isTokenContains() async {
    final data = await _db.read(SecureStorageParams(key: _keys.accessTokenKey));
    return data != null;
  }

  @override
  Future<void> updateToken({required String accessToken}) async {
    await _db.create(
      SecureStorageParams(key: _keys.accessTokenKey, value: accessToken),
    );
  }

  @override
  Future<void> setData({required String key, required dynamic value}) async {
    await _db.create(SecureStorageParams(key: key, value: value));
  }

  @override
  Future<dynamic> getData(String key) async {
    await _db.read(SecureStorageParams(key: key));
  }

  @override
  Future<void> setIsAuthenticated(bool value) async {
    await _db.create(
      SecureStorageParams(key: _keys.isAuthenticatedKey, value: value.toString()),
    );
  }

  @override
  Future<bool> getIsAuthenticated() async {
    final value = await _db.read(
      SecureStorageParams(key: _keys.isAuthenticatedKey),
    );
    return value == 'true';
  }

  @override
  Future<void> setIsLoggedIn({required bool value}) async{
    await _db.create(SecureStorageParams(key: _keys.isLoggedInKey,value: value.toString()));
  }

  @override
  Future<bool> getIsLoggedIn() async{
    final value = await _db.read(SecureStorageParams(key: _keys.isLoggedInKey));
    return value == 'true';
  }
}
