import 'package:dev_hub/core/errors/failures.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/user_entity.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> githubAuthentication();

  Future<Either<Failure, UserEntity?>> getCurrentUser();

  Future<bool> isLoggedIn();

  Future<Either<Failure, void>> logOut();
}
