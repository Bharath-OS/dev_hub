import 'package:dev_hub/features/teams_management/domain/entity/team_entity.dart';
import 'package:dev_hub/features/teams_management/params/team_params.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';

abstract interface class TeamsRepositoryInterface {
  Future<Either<Failure, Stream<List<TeamEntity>>>> getTeams(String workspaceId);

  Future<Either<Failure, TeamEntity>> createTeam({required TeamParams teamParams});

  Future<Either<Failure, void>> updateTeam({required TeamParams params});

  Future<Either<Failure, String>> deleteTeam(TeamParams params);
}
