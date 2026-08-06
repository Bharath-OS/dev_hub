import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/errors/failures.dart';
import 'local_db_contract.dart';

class SecureStorageImpl implements LocalDatabase {
  final FlutterSecureStorage storage;

  SecureStorageImpl(this.storage);

  @override
  Future<void> save(String key, dynamic value) async {
    try {
      await storage.write(key: key, value: value);
    } catch (e) {
      throw Failure('Something went wrong when storing.');
    }
  }

  @override
  Future<String?> readData(String key) async {
    try {
      return await storage.read(key: key);
    } catch (e) {
      throw Failure();
    }
  }

  @override
  Future<void> clearAll() async{
    try{
      await storage.deleteAll();
    }catch(e){
      throw Failure();
    }
  }

  @override
  Future<void> delete(String key) async{
    try{
      await storage.delete(key: key);
    }catch(e){
      throw Failure();
    }
  }

  @override
  Future<bool> isContains(String key)async{
    try{
      return await storage.containsKey(key: key);
    }catch(e){
      throw Failure();
    }
  }
}
