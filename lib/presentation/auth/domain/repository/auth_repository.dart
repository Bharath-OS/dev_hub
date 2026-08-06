import 'package:dev_hub/core/errors/failures.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/user_entity.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> githubAuthentication();

  /// Fetches the currently-authenticated user's document from remote storage.
  /// Returns [null] on the right side if the user is authenticated but has no
  /// Firestore document yet (first-time login edge case).
  Future<Either<Failure, UserEntity?>> getCurrentUser();
}
