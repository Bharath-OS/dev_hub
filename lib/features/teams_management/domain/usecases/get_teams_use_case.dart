import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/features/teams_management/domain/entity/team_entity.dart';
import 'package:dev_hub/features/teams_management/domain/repository/teams_repository_interface.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/usecases/usecase.dart';

class GetTeamsUseCase implements UseCase<Stream<List<TeamEntity>>,String>{
  final TeamsRepositoryInterface _repository;

  GetTeamsUseCase(this._repository);
  
  @override
  Future<Either<Failure, Stream<List<TeamEntity>>>> call(String workspaceId) async {
    final stream = await _repository.getTeams(workspaceId);
    return stream;
  }
}