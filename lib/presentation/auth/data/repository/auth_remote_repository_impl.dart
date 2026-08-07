import 'package:dev_hub/core/errors/failures.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasource/local/local_datasource_impl.dart';
import '../datasource/remote/auth_data_source.dart';
import '../datasource/remote/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authenticate;
  final AuthLocalDataSourceImpl localDB;
  final AuthRemoteDatabaseImpl remoteDB;
  final FirebaseAuth firebaseAuth;

  AuthRepositoryImpl({
    required this.remoteDB,
    required this.authenticate,
    required this.localDB,
    required this.firebaseAuth,
  });

  @override
  Future<Either<Failure, UserEntity>> githubAuthentication() async {
    try {
      final userModel = await authenticate.authenticate();
      final String? accessToken = userModel.githubAccessToken;

      if (accessToken == null || accessToken.isEmpty) {
        return left(
          Failure("GitHub authentication failed: Access token missing"),
        );
      }

      // Save token locally for subsequent API calls
      await localDB.updateToken(accessToken: accessToken);

      // Save the basic user profile to the remote database
      await remoteDB.saveUser(user: userModel);

      return right(userModel);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final currentFirebaseUser = firebaseAuth.currentUser;

      if (currentFirebaseUser == null) return right(null);

      final userModel = await remoteDB.getUser(id: currentFirebaseUser.uid);

      if (userModel == null) return right(null);

      return right(userModel);
    } catch (e) {
      return left(Failure('Failed to restore session: ${e.toString()}'));
    }
  }
}
