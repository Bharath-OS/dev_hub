import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../../data/datasources/database_contract.dart';
import '../../../../../core/params/firestore_params.dart';
import '../../models/user_model.dart';

class AuthRemoteDatabaseImpl {
  final Database _dbService;
  final String _collectionPath = 'Users';
  AuthRemoteDatabaseImpl(this._dbService);

  Future<void> saveUser({required UserModel user}) async {
    final params = FirestoreParams(
      collectionPath: _collectionPath,
      id: user.id,
      data: user.toMap(),
    );
    await _dbService.create(params);
  }

  Future<UserModel?> getUser({required String id}) async {
    final DocumentSnapshot<Map<String, dynamic>?> docSnapshot = await _dbService.read(
      FirestoreParams(id: id, collectionPath: _collectionPath),
    );
    final data = docSnapshot.data();
    if (data == null) return null; // covers both non-existent and empty

    return UserModel.fromMap(data);
  }

  Future<void> deleteUser({required String id}) async {
    await _dbService.delete(FirestoreParams(collectionPath: _collectionPath, id: id));
  }
}
