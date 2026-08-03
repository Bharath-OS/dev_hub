import 'package:dev_hub/core/constants/local_storage_keys.dart';
import 'package:dev_hub/data/datasources/local/local_db_contract.dart';

class AuthLocalDataSourceImpl{
  final LocalDatabase _local;

  AuthLocalDataSourceImpl(this._local);

  final String _key = Keys.accessTokenKey;

  Future<void> storeUserToken({required String userToken}) async {
    await _local.save(_key, userToken);
  }

  Future<String?> getToken() async{
    return await _local.readData(_key);
  }

  Future<bool> isTokenContains() async{
    return await _local.isContains(_key);
  }

  Future<void> updateToken({required String accessToken}) async {
    // LocalDatabase.save (SecureStorage.write) already overwrites the existing value.
    await _local.save(_key, accessToken);
  }

}