import 'package:fpdart/fpdart.dart';
import '../../../../../core/errors/failures.dart';
import '../entity/repository_entity.dart';
import '../entity/workspace_entity.dart';

abstract interface class WorkspaceRepository {
  Future<Either<Failure, WorkspaceEntity>> createWorkspace(WorkspaceParams params);

  Future<Either<Failure, WorkspaceEntity>> updateWorkspace(WorkspaceParams updated);

  Future<Either<Failure, List<GitHubRepositoryEntity>>> getRepositories(WorkspaceParams workspaceParams);

  Stream<List<WorkspaceEntity>> getWorkspaces(String userId);
}