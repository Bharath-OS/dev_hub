import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/core/usecases/usecase.dart';
import 'package:dev_hub/features/workspace/domain/entity/github_repository_entity.dart';
import 'package:fpdart/fpdart.dart';
import '../entity/workspace_entity.dart';
import '../repository/workspace_repo.dart';

class CreateWorkspaceUsecase implements UseCase<WorkspaceEntity, WorkspaceParams> {
  final WorkspaceRepository repo;
  CreateWorkspaceUsecase(this.repo);

  @override
  Future<Either<Failure,WorkspaceEntity>> call(WorkspaceParams params) async {
    try {
      return await repo.createWorkspace(params);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}

class UpdateWorkspaceUsecase implements UseCase<WorkspaceEntity, WorkspaceParams>{
  final WorkspaceRepository _repository;
  UpdateWorkspaceUsecase(this._repository);

  @override
  Future<Either<Failure, WorkspaceEntity>> call(WorkspaceParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

class GetWorkspaceUseCase implements UseCase<Stream<List<WorkspaceEntity>>, String> {
  final WorkspaceRepository _repository;
  GetWorkspaceUseCase(this._repository);

  @override
  Future<Either<Failure, Stream<List<WorkspaceEntity>>>> call(String userId) async {
    try {
      final stream = _repository.getWorkspaces(userId);
      return right(stream);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}

class GetRepositoriesUseCase implements UseCase<List<GitHubRepositoryEntity>,String>{
  final WorkspaceRepository _repository;
  GetRepositoriesUseCase(this._repository);

  @override
  Future<Either<Failure,List<GitHubRepositoryEntity>>> call(String orgName) async {
      final repositories = await _repository.getRepositories(orgName);
      return repositories;
  }
}