import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/core/usecases/usecase.dart';
import 'package:fpdart/fpdart.dart';
import '../../entities/user_entity.dart';
import '../../repository/org_repository.dart';

class FetchUserOrgsUseCase implements UseCase<UserEntity, UserEntity> {
  final OrgRepository orgRepository;

  FetchUserOrgsUseCase(this.orgRepository);

  @override
  Future<Either<Failure, UserEntity>> call(UserEntity user) async {
    return await orgRepository.fetchOrganizations(user);
  }
}
