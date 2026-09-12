import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/features/teams_management/domain/entity/team_entity.dart';
import 'package:dev_hub/features/teams_management/domain/repository/teams_repository_interface.dart';
import 'package:dev_hub/features/teams_management/params/team_params.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/usecases/usecase.dart';

class CreateTeamUseCase implements UseCase<TeamEntity, TeamParams> {
  final TeamsRepositoryInterface _repository;

  CreateTeamUseCase(this._repository);
  @override
  Future<Either<Failure, TeamEntity>> call(TeamParams params) async {
    return await _repository.createTeam(teamParams: params);
  }
}
