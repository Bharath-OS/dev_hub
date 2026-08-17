import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/features/auth/data/datasource/local/auth_local_database_impl.dart';
import 'package:dev_hub/features/auth/data/datasource/local/auth_local_database_interface.dart';
import 'package:dev_hub/features/workspace/data/Datasource/github_workspace_datasource.dart';
import 'package:dev_hub/features/workspace/domain/entity/repository_entity.dart';
import 'package:dev_hub/shared/data/datasources/local/token_manager.dart';
import 'package:dev_hub/shared/data/datasources/remote/github_api_data_source.dart';
import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';
import '../../domain/entity/workspace_entity.dart';
import '../../domain/repository/workspace_repo.dart';
import '../Datasource/workspace_datasource.dart';

class WorkspaceRepositoryImpl implements WorkspaceRepository {
  final WorkspaceDataSource _dataSource;
  final GithubWorkspaceDataSource _githubApiService;
  final TokenManager _tokenManager;

  WorkspaceRepositoryImpl({
    required this._dataSource,
    required this._githubApiService,
    required this._tokenManager,
  });

  @override
  Future<Either<Failure, WorkspaceEntity>> createWorkspace(
    WorkspaceParams params,
  ) async {
    try {
      final result = await _dataSource.createWorkspace(params);
      return right(result);
    } catch (error) {
      return left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, WorkspaceEntity>> updateWorkspace(
    WorkspaceParams updatedWorkspace,
  ) async {
    try {
      final updatedWorkspaceModel = await _dataSource.updateWorkspace(
        updatedWorkspace,
      );
      return right(updatedWorkspaceModel);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GitHubRepositoryEntity>>> getRepositories(
    WorkspaceParams workspaceParams,
  ) async {
    final accessToken = await _tokenManager.getToken();
    if (accessToken == null) {
      return left(Failure("Couldn't find user access token"));
    }
    try {
      final repositoryList = await _githubApiService.getRepositories(
        orgName: workspaceParams.githubOrgLogin,
        accessToken: accessToken,
      );
      for (var repo in repositoryList) {
        print(
          "Here is the repo name: ${repo.name} and full name: ${repo.fullName} and ${repo.htmlUrl}",
        );
      }
      return right(repositoryList);
    } catch (error) {
      if (error is Failure) {
        return left(error);
      }
      return left(Failure(error.toString()));
    }
  }
}
