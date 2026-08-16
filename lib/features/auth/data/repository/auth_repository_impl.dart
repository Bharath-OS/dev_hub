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

      //checks if the user is authenticated or not.
      final isAuthenticated = await _localDB.getIsAuthenticated();
      if(!isAuthenticated) return right(null);

      //checks Firebase session.
      final currentFirebaseUser = _firebaseAuth.currentUser;
      if (currentFirebaseUser == null) {
        await _localDB.setIsAuthenticated(false);
        return right(null);
      }

      //verifies firestore document exists.
      final userModel = await _remoteDB.getUser(id: currentFirebaseUser.uid);
      if (userModel == null) {
        await _localDB.setIsAuthenticated(false);
        await _localDB.setIsLoggedIn(value: false);
        return left(AuthFailure("User data not found in database."));
      }

      // 1. Fetch the GitHub access token from local storage
      final localToken = await _localDB.getToken();
      
      // 2. Attach the token to the user model so subsequent API calls don't fail
      final userWithToken = userModel.copyWith(githubAccessToken: localToken);

      return right(userWithToken);
    } catch (e) {
      if (e is Failure) return left(e);
      return left(Failure('Failed to restore session: ${e.toString()}'));
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    return await _localDB.getIsLoggedIn();
  }
}
