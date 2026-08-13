import 'package:dev_hub/core/errors/failures.dart';
import 'package:fpdart/fpdart.dart';
import '../../domain/entity/workspace_entity.dart';
import '../../domain/repository/workspace_repo.dart';
import '../Datasource/workspace_datasource.dart';

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