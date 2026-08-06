import 'package:dev_hub/core/constants/local_storage_keys.dart';
import 'package:dev_hub/core/params/secure_storage_params.dart';
import '../../../../../data/datasources/database_interface.dart';

class AuthLocalDataSourceImpl {
  final Database _db;

  AuthLocalDataSourceImpl(this._db);

  final String _key = Keys.accessTokenKey;

  Future<void> storeUserToken({required String userToken}) async {
    final params = SecureStorageParams(key: _key, value: userToken);
    await _db.create(params);
  }

  Future<String?> getToken() async {
    return await _db.read(SecureStorageParams(key: _key));
  }

  Future<bool> isTokenContains() async {
    final data = await _db.read(_key);
    if(data == null){
      return false;
    }return true;
  }

  Future<void> updateToken({required String accessToken}) async {
    await _db.create(SecureStorageParams(key: _key, value: accessToken));
  }
}
