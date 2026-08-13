import '../../models/user_model.dart';

abstract interface class AuthRemoteDatabaseInterface {
  Future<void> saveUser({required UserModel user});

  Future<UserModel?> getUser({required String id});

  Future<void> updateUser({required String userId, required Map<String, dynamic> fields});

  Future<void> deleteUser({required String id});
}