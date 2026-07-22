import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/core/usecases/usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import '../../repository/auth/auth_repository.dart';

class AuthUseCase implements UseCase<UserCredential,dynamic>{
  final AuthRepository authRepo;

  AuthUseCase(this.authRepo);
  @override
  Future<Either<Failures, UserCredential>> call(params) async{
    return await authRepo.githubAuthentication();
  }
}