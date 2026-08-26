import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/core/usecases/usecase.dart';
import 'package:dev_hub/features/auth/domain/entities/user_entity.dart';
import 'package:fpdart/src/either.dart';

class EditUserDetailsUsecase implements UseCase<UserEntity, String>{
  @override
  Future<Either<Failure, UserEntity>> call(String params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}