import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/core/utils/api_response_validator.dart';
import 'package:dev_hub/features/teams_management/data/datasource/teams_github_datasource.dart';
import 'package:dev_hub/features/teams_management/data/model/team_model.dart';
import 'package:dev_hub/features/teams_management/domain/entity/team_entity.dart';
import 'package:dev_hub/features/teams_management/domain/repository/teams_repository_interface.dart';
import 'package:dev_hub/features/teams_management/params/team_params.dart';
import 'package:fpdart/fpdart.dart';

class TeamsRepositoryImpl implements TeamsRepositoryInterface {
  final TeamsGitHubDataSource _gitHubDataSource;

  TeamsRepositoryImpl(this._gitHubDataSource);

  @override
  Future<Either<Failure, TeamEntity>> createTeam({
    required TeamParams teamParams,
  }) async {
    final result = await _gitHubDataSource.createGitHubTeam(
      orgName: teamParams.orgName!,
      teamParams: teamParams,
    );
    final response = ApiResponseValidator.validate(result);
    return response.fold(
      (failure) => left(failure),
      (apiResponse) => right(TeamModel.fromMap(apiResponse.data)),
    );
  }

  @override
  Future<Either<Failure, String>> deleteTeam(TeamParams teamParams) async {
    try {
      await _gitHubDataSource.deleteTeam(
        orgName: teamParams.orgName!,
        teamSlug: teamParams.githubTeamSlug!,
      );
      return right("Team deleted successfully");
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TeamEntity>>> getTeams(
    TeamParams teamParams,
  ) async {
    try {
      final result = await _gitHubDataSource.getAllTeams(
        orgName: teamParams.orgName!,
      );
      final response = ApiResponseValidator.validate(result);
      return response.fold(
        (failure) => left(failure),
        (apiResponse) {
          final List<dynamic> data = apiResponse.data;
          return right(data.map((e) => TeamModel.fromMap(e)).toList());
        },
      );
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> updateTeam({required TeamParams params}) async {
    try {
      final result = await _gitHubDataSource.modifyTeamDetails(teamParams: params);
      final response = ApiResponseValidator.validate(result);
      return response.fold(
        (failure) => left(failure),
        (apiResponse) => right("Team updated successfully"),
      );
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
