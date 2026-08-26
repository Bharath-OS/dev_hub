import 'package:dev_hub/features/auth/domain/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';

abstract interface class UserProfileRepository {
  Future<Either<Failure, UserEntity>> editUserDetails();
}