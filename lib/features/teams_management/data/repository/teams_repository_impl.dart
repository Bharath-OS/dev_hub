import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/core/utils/api_response_validator.dart';
import 'package:dev_hub/features/teams_management/data/datasource/teams_github_datasource.dart';
import 'package:dev_hub/features/teams_management/data/datasource/teams_remote_data_source_impl.dart';
import 'package:dev_hub/features/teams_management/data/model/team_model.dart';
import 'package:dev_hub/features/teams_management/domain/entity/team_entity.dart';
import 'package:dev_hub/features/teams_management/domain/repository/teams_repository_interface.dart';
import 'package:dev_hub/features/teams_management/params/team_params.dart';
import 'package:fpdart/fpdart.dart';

class TeamsRepositoryImpl implements TeamsRepositoryInterface {
  final TeamsGitHubDataSource _gitHubDataSource;
  final TeamsRemoteDataSource _remoteDataSource;

  TeamsRepositoryImpl({
    required this._gitHubDataSource,
    required this._remoteDataSource,
  });

  @override
  Future<Either<Failure, TeamEntity>> createTeam({
    required TeamParams teamParams,
  }) async {
    try {
      final result = await _gitHubDataSource.createGitHubTeam(
        orgName: teamParams.orgName!,
        teamParams: teamParams,
      );
      final response = ApiResponseValidator.validate(result);
      return await response.fold(
        (failure) async => left(failure),
        (apiResponse) async {
          final teamModel = TeamModel.fromMap(apiResponse.data);
          // Inject workspaceId and use GitHub ID as document ID
          final teamWithWorkspace = teamModel.copyWith(
            workspaceId: teamParams.workspaceId,
            id: teamModel.githubTeamId.toString(),
            githubRepoFullName: teamParams.githubRepoFullName,
            githubRepoName: teamParams.githubRepoFullName!.split('/').last
          );
          final savedTeam = await _remoteDataSource.createTeam(teamWithWorkspace);
          return right(savedTeam);
        },
      );
    } catch (e) {
      return left(Failure(e.toString()));
    }
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
  Future<Either<Failure, Stream<List<TeamEntity>>>> getTeams(
    String workspaceId,
  ) async {
    try {
      final result = await _remoteDataSource.getTeams(workspaceId);
      return right(result);
    } catch (error) {
      return left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateTeam({
    required TeamParams params,
  }) async {
    try {
      final result = await _gitHubDataSource.modifyTeamDetails(
        teamParams: params,
      );
      final response = ApiResponseValidator.validate(result);
      return response.fold(
        (failure) => left(failure),
        (apiResponse) => right(null),
      );
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
