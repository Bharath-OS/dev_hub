import 'package:dev_hub/core/errors/failures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasource/local/auth_local_database_interface.dart';
import '../datasource/remote/auth_remote_data_source.dart';
import '../datasource/remote/auth_remote_database_interface.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authService;
  final AuthLocalDatabaseInterface _localDB;
  final AuthRemoteDatabaseInterface _remoteDB;
  final FirebaseAuth _firebaseAuth;

  AuthRepositoryImpl({
    required this._remoteDB,
    required this._authService,
    required this._localDB,
    required this._firebaseAuth,
  });

  @override
  Future<Either<Failure, UserEntity>> githubAuthentication() async {
    try {
      final userModel = await _authService.authenticate();
      final String? accessToken = userModel.githubAccessToken;

      if (accessToken == null || accessToken.isEmpty) {
        return left(
          Failure("GitHub authentication failed: Access token missing"),
        );
      }

      // Save token locally for subsequent API calls
      await _localDB.updateToken(accessToken: accessToken);

      // Sets isAuthenticated flag locally
      await _localDB.setIsAuthenticated(true);

      // Save the basic user profile to the remote database
      await _remoteDB.saveUser(user: userModel);

      return right(userModel);
    } catch (e) {
      if (e is Failure) return left(e);
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final isAuthenticate = await _localDB.getIsAuthenticated();
      if(isAuthenticate.toString() == 'false'){
        return left(Failure('User hasn\'t authenticated.'));
      }
      final currentFirebaseUser = _firebaseAuth.currentUser;

      if (currentFirebaseUser == null) return right(null);

      final userModel = await _remoteDB.getUser(id: currentFirebaseUser.uid);

      if (userModel == null) return right(null);

      return right(userModel);
    } catch (e) {
      return left(Failure('Failed to restore session: ${e.toString()}'));
    }
  }
}
