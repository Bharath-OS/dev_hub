import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/core/usecases/usecase.dart';
import 'package:fpdart/fpdart.dart';
import '../entity/workspace_entity.dart';
import '../repository/workspace_repo.dart';

class CreateWorkspace implements UseCase<void, WorkspaceEntity> {
  final WorkspaceRepository repo;
  CreateWorkspace(this.repo);

  @override
  Future<Either<Failure, void>> call(WorkspaceEntity params) async {
    try {
      await repo.createWorkspace(params);
      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
