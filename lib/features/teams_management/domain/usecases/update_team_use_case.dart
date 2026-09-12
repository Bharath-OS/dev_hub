import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/features/teams_management/domain/repository/teams_repository_interface.dart';
import 'package:dev_hub/features/teams_management/params/team_params.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/usecases/usecase.dart';

class UpdateTeamUseCase implements UseCase<void, TeamParams>{
  final TeamsRepositoryInterface _repository;
  UpdateTeamUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(TeamParams params) async {
    return await _repository.updateTeam(params: params);
  }
}