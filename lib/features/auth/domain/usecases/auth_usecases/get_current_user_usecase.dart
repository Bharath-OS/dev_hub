import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/core/usecases/usecase.dart';
import 'package:fpdart/fpdart.dart';
import '../../entities/user_entity.dart';
import '../../repository/auth_repository.dart';

class GetCurrentUserUseCase implements UseCase<UserEntity?, NoParams> {
  final AuthRepository authRepository;

  GetCurrentUserUseCase(this.authRepository);

  @override
  Future<Either<Failure, UserEntity?>> call(NoParams params) async {
    return await authRepository.getCurrentUser();
  }
}
