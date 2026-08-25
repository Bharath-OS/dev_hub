import 'package:dev_hub/features/membership/domain/entity/invited_user_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';

abstract interface class MembershipRepository {
  Future<Either<Failure, List<InvitedUserEntity>>> searchUser(String searchQuery);
}