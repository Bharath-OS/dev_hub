import 'package:dev_hub/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends UserEntity {
  UserModel(
    String uid,
    String name,
    String email,
    String? photoURL,
    String accessToken,
  ) : super(uid: uid, name: name, email: email, accessToken: accessToken);

  factory UserModel.fromRemoteSource(UserCredential credential) {
    return UserModel(
      credential.user!.uid,
      credential.user!.displayName!,
      credential.user!.email!,
      credential.user?.photoURL,
      credential.user!.refreshToken!,
    );
  }
}
