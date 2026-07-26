import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/domain/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class OrgRepository {
  Future<Either<Failures, UserEntity>> fetchOrganizations(UserEntity user);
}
