import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/core/usecases/usecase.dart';
import 'package:fpdart/fpdart.dart';
import '../../entities/user_entity.dart';
import '../../repository/org_repository.dart';

class UpdateOrgParams {
  final UserEntity user;
  final GitHubOrgInfo selectedOrg;

  const UpdateOrgParams({required this.user, required this.selectedOrg});
}

class UpdateOrganizationUseCase
    implements UseCase<UserEntity, UpdateOrgParams> {
  final OrgRepository orgRepository;

  UpdateOrganizationUseCase(this.orgRepository);

  @override
  Future<Either<Failure, UserEntity>> call(UpdateOrgParams params) async {
    return await orgRepository.updateCurrentOrganization(
      user: params.user,
      selectedOrg: params.selectedOrg,
    );
  }
}
