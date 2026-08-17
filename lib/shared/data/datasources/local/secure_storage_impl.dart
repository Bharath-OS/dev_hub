import 'package:dev_hub/core/params/secure_storage_params.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/errors/failures.dart';
import '../database_interface.dart';

class SecureStorageImpl implements DatabaseInterface<SecureStorageParams, dynamic> {
  final FlutterSecureStorage storage;

  SecureStorageImpl(this.storage);

  @override
  Future<void> create(SecureStorageParams params) async {
    try {
      await storage.write(key: params.key, value: params.value);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> update(SecureStorageParams params) async{
    await create(params);
  }

  @override
  Future<String?> read(SecureStorageParams params) async {
    try {
      return await storage.read(key: params.key);
    } catch (e) {
      throw Failure();
    }
  }

  // @override
  Future<void> clearAll() async{
    try{
      await storage.deleteAll();
    }catch(e){
      throw Failure();
    }
  }

  @override
  Future<void> delete(SecureStorageParams params) async{
    try{
      await storage.delete(key: params.key);
    }catch(e){
      throw Failure();
    }
  }

  // @override
  Future<bool> isContains(String key)async{
    try{
      return await storage.containsKey(key: key);
    }catch(e){
      throw Failure();
    }
  }

  @override
  Future<Map<String, String>?> readAll(SecureStorageParams params) async {
    try{
      return await storage.readAll();
    }catch(e){
      throw Failure();
    }
  }
}
