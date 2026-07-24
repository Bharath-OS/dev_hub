import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failures, UserEntity>> githubAuthentication();
}
