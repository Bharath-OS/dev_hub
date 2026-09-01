import 'package:firebase_auth/firebase_auth.dart';

import '../../../auth/data/models/user_model.dart';

abstract interface class ProfileRemoteDataSource {
  Future<UserModel> updateDisplayName({
    required String newDisplayName,
  });
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  ProfileRemoteDataSourceImpl(this._firebaseAuth);

  @override
  Future<UserModel> updateDisplayName({
    required String newDisplayName,
  }) async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      throw Exception('No authenticated user found');
    }

    await currentUser.updateDisplayName(newDisplayName);
    await currentUser.reload();

    final updatedUser = _firebaseAuth.currentUser;
    if (updatedUser == null) {
      throw Exception('Failed to reload user after update');
    }

    return UserModel(
      id: updatedUser.uid,
      githubId: 0,
      githubUsername: updatedUser.displayName ?? '',
      displayName: updatedUser.displayName ?? '',
      email: updatedUser.email ?? '',
      avatarUrl: updatedUser.photoURL,
      createdAt: DateTime.now(),
      lastSeen: DateTime.now(),
    );
  }
}
