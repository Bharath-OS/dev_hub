import 'package:dev_hub/presentation/pages/workspace/domain/entity/workspace_entity.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../../core/errors/failures.dart';

abstract interface class WorkspaceRepository {
  Future<void> createWorkspace(WorkspaceEntity params);

  Future<Either<void, Failure>> updateWorkspace(WorkspaceEntity updated);
}