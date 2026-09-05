import 'package:dev_hub/features/workspace/domain/entity/workspace_entity.dart';
import 'package:dev_hub/features/workspace/domain/usecases/workspace_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'workspace_event.dart';
part 'workspace_state.dart';

class WorkspaceBloc extends Bloc<WorkspaceEvent, WorkspaceState> {
  final GetWorkspaceUseCase _getWorkspaceUseCase;
  List<WorkspaceEntity> _currentWorkspaces = [];

  WorkspaceBloc({
    required this._getWorkspaceUseCase,
  }) : super(WorkspaceInitial()) {
    on<WatchWorkspacesEvent>((event, emit) async {
      emit(WorkspaceLoadingState());
      final result = await _getWorkspaceUseCase.call(event.userId);
      await result.fold(
        (failure) async => emit(WorkspaceFailure(failure.message)),
        (stream) async {
          await emit.forEach<List<WorkspaceEntity>>(
            stream,
            onData: (workspaces) {
              _currentWorkspaces = workspaces;
              return WorkspaceLoaded(workspaces);
            },
            onError: (error, stackTrace) => WorkspaceFailure(error.toString()),
          );
        },
      );
    });
  }
}
