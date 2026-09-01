import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/core/usecases/usecase.dart';
import 'package:dev_hub/features/auth/domain/entities/user_entity.dart';
import 'package:dev_hub/features/profile/domain/params/user_params.dart';
import 'package:fpdart/fpdart.dart';

import '../repository/user_profile_repository.dart';

class EditUserDetailsUsecase implements UseCase<UserEntity, UserParams> {
  final UserProfileRepository _repository;

  EditUserDetailsUsecase(this._repository);

  @override
  Future<Either<Failure, UserEntity>> call(UserParams params) {
    return _repository.editUserDetails(params);
  }
}
