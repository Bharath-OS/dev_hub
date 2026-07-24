import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/core/usecases/usecase.dart';
import 'package:fpdart/fpdart.dart';
import '../../entities/user_entity.dart';
import '../../repository/auth/auth_repository.dart';

class AuthUseCase implements UseCase<UserEntity,dynamic>{
  final AuthRepository authRepo;

  AuthUseCase(this.authRepo);
  @override
  Future<Either<Failures, UserEntity>> call(params) async{
    return await authRepo.githubAuthentication();
  }
}