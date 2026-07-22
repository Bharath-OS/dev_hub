import 'package:dev_hub/core/errors/failures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failures, UserCredential>> githubAuthentication();
}
