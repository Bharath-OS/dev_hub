import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/core/usecases/usecase.dart';
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
