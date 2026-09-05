import 'package:fpdart/fpdart.dart';
import '../../../../../core/errors/failures.dart';
import '../entity/github_repository_entity.dart';
import '../entity/workspace_entity.dart';

abstract interface class WorkspaceRepository {
  Future<Either<Failure, WorkspaceEntity>> createWorkspace(WorkspaceParams params);

  Future<Either<Failure, WorkspaceEntity>> updateWorkspace(WorkspaceParams updated);

  Future<Either<Failure, List<GitHubRepositoryEntity>>> getRepositories(String orgName);

  Stream<List<WorkspaceEntity>> getWorkspaces(String userId);

  Future<Either<Failure, bool>> deleteWorkspace(WorkspaceEntity workspace);
}