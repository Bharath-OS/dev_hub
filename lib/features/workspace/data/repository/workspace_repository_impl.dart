import 'package:dev_hub/core/errors/failures.dart';
import 'package:fpdart/fpdart.dart';
import '../../domain/entity/workspace_entity.dart';
import '../../domain/repository/workspace_repo.dart';
import '../Datasource/workspace_datasource.dart';

class WorkspaceRepositoryImpl implements WorkspaceRepository{
  final WorkspaceDataSource _dataSource;

  WorkspaceRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure,WorkspaceEntity>> createWorkspace(WorkspaceParams params) async {
    try{
      final result =  await _dataSource.createWorkspace(params);
      return right(result);
    }catch (error){
      return left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, WorkspaceEntity>> updateWorkspace(WorkspaceParams updatedWorkspace) async{
    try{
      final updatedWorkspaceModel = await _dataSource.updateWorkspace(updatedWorkspace);
      return right(updatedWorkspaceModel);
    }catch(e){
      return left(Failure(e.toString()));
    }
  }
}