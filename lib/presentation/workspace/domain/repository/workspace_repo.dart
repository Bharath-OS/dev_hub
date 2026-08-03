import 'package:fpdart/fpdart.dart';
import '../../../../../core/errors/failures.dart';
import '../entity/workspace_entity.dart';

abstract interface class WorkspaceRepository {
  Future<void> createWorkspace(WorkspaceEntity params);

  Future<Either<void, Failure>> updateWorkspace(WorkspaceEntity updated);
}