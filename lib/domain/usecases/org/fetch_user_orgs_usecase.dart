import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/core/usecases/usecase.dart';
import 'package:dev_hub/domain/entities/user_entity.dart';
import 'package:dev_hub/domain/repository/org/org_repository.dart';
import 'package:fpdart/fpdart.dart';

class FetchUserOrgsUseCase implements UseCase<UserEntity, UserEntity> {
  final OrgRepository orgRepository;

  FetchUserOrgsUseCase(this.orgRepository);

  @override
  Future<Either<Failures, UserEntity>> call(UserEntity user) async {
    return await orgRepository.fetchOrganizations(user);
  }
}
