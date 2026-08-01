import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/presentation/pages/workspace/data/Datasource/workspace_datasource.dart';
import 'package:dev_hub/presentation/pages/workspace/domain/entity/workspace_entity.dart';
import 'package:dev_hub/presentation/pages/workspace/domain/repository/workspace_repo.dart';
import 'package:fpdart/fpdart.dart';

class WorkspaceRepositoryImpl implements WorkspaceRepository{
  final WorkspaceDataSource _dataSource;

  WorkspaceRepositoryImpl(this._dataSource);

  @override
  Future<void> createWorkspace(WorkspaceEntity params) async {
    await _dataSource.createWorkspace(params);
  }

  @override
  Future<Either<void, Failure>> updateWorkspace(WorkspaceEntity updated) {
    // TODO: implement updateWorkspace
    throw UnimplementedError();
  }
}