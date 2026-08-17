import 'package:dev_hub/features/workspace/domain/entity/workspace_entity.dart';
import 'package:dev_hub/features/workspace/domain/usecases/workspace_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart';
part 'workspace_event.dart';
part 'workspace_state.dart';

class WorkspaceBloc extends Bloc<WorkspaceEvent, WorkspaceState> {
  final CreateWorkspaceUsecase _createWorkspaceUsecase;
  final List<WorkspaceEntity> workspaces = [];

  WorkspaceBloc(this._createWorkspaceUsecase) : super(WorkspaceInitial()) {
    on<CreateWorkspaceEvent>((event, emit) async{
      emit(WorkspaceLoadingState());
      try{
        final response = await _createWorkspaceUsecase.call(event.params);
        response.fold((error)=>emit(WorkspaceFailure(error.message)), (workspace){
          emit(WorkspaceCreated(workspace));
          workspaces.add(workspace);
        });
      }on Failure catch(error){
        emit(WorkspaceFailure(error.message));
    }catch (e){
        emit(WorkspaceFailure(e.toString()));
      }
    });
  }
}
