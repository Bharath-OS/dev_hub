import 'package:dev_hub/core/errors/failures.dart';
import 'package:fpdart/fpdart.dart';
import '../entities/user_entity.dart';

abstract interface class OrgRepository {
  Future<Either<Failure, UserEntity>> fetchOrganizations(UserEntity user);
}
