import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../../core/params/firestore_params.dart';
import '../../../../../shared/data/datasources/database_interface.dart';
import '../../models/user_model.dart';
import 'auth_remote_database_interface.dart';

class AuthRemoteDatabaseImpl implements AuthRemoteDatabaseInterface{
  final DatabaseInterface _dbService;
  final String _collectionPath = 'Users';
  AuthRemoteDatabaseImpl(this._dbService);

  @override
  Future<void> saveUser({required UserModel user}) async {
    final params = FirestoreParams(
      collectionPath: _collectionPath,
      id: user.id,
      data: user.toMap(),
    );
    await _dbService.create(params);
  }

  @override
  Future<UserModel?> getUser({required String id}) async {
    final DocumentSnapshot<Map<String, dynamic>?> docSnapshot = await _dbService
        .read(FirestoreParams(id: id, collectionPath: _collectionPath));
    final data = docSnapshot.data();
    if (data == null) return null; // covers both non-existent and empty

    return UserModel.fromMap(data);
  }

  @override
  Future<void> updateUser({
    required String userId,
    required Map<String, dynamic> fields,
  }) async {
    await _dbService.update(
      FirestoreParams(
        collectionPath: _collectionPath,
        id: userId,
        data: fields,
      ),
    );
  }

  @override
  Future<void> deleteUser({required String id}) async {
    await _dbService.delete(
      FirestoreParams(collectionPath: _collectionPath, id: id),
    );
  }
}
