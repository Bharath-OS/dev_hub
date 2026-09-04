import 'package:dev_hub/features/workspace/domain/entity/workspace_entity.dart';
import 'package:dev_hub/features/workspace/domain/usecases/workspace_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/errors/failures.dart';

part 'workspace_action_event.dart';
part 'workspace_action_state.dart';

class WorkspaceActionBloc
    extends Bloc<WorkspaceActionEvent, WorkspaceActionState> {
  final CreateWorkspaceUsecase _createWorkspaceUseCase;
  final DeleteWorkspaceUseCase _deleteWorkspaceUseCase;
  final UpdateWorkspaceUseCase _editWorkspaceUseCase;
  List<WorkspaceEntity> _currentWorkspaces = [];

  WorkspaceActionBloc({
    required this._createWorkspaceUseCase,
    required this._deleteWorkspaceUseCase,
    required this._editWorkspaceUseCase,
  }) : super(WorkspaceActionInitial()) {
    on<CreateWorkspaceEvent>((event, emit) async {
      try {
        final response = await _createWorkspaceUseCase.call(event.params);
        response.fold(
          (error) => emit(WorkspaceActionFailure(error.message)),
          (workspace) => emit(WorkspaceCreated(workspace, _currentWorkspaces)),
        );
      } on Failure catch (error) {
        emit(WorkspaceActionFailure(error.message));
      } catch (e) {
        emit(WorkspaceActionFailure(e.toString()));
      }
    });
    on<DeleteWorkspaceEvent>((event, emit) async {
      emit(WorkspaceDeletingState());
      try {
        final response = await _deleteWorkspaceUseCase.call(event.workspace);
        response.fold(
          (failure) => emit(WorkspaceActionFailure(failure.message)),
          (success) => success
              ? emit(WorkspaceDeletedState())
              : emit(WorkspaceActionFailure('Failed to delete the workspace')),
        );
      } on Failure catch (error) {
        emit(WorkspaceActionFailure(error.message));
      } catch (e) {
        emit(WorkspaceActionFailure(e.toString()));
      }
    });
    on<ModifyWorkspaceEvent>((event, emit) async {
      emit(WorkspaceEditingState());
      try {
        final response = await _editWorkspaceUseCase.call(event.params);
        response.fold(
          (failure) => emit(WorkspaceActionFailure(failure.message)),
          (modifiedWorkspace) => emit(WorkspaceEditedState(modifiedWorkspace)),
        );
      } catch (e) {
        emit(WorkspaceActionFailure(e.toString()));
      }
    });
  }
}
