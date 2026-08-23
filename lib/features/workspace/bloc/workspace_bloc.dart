import 'package:dev_hub/features/workspace/domain/entity/workspace_entity.dart';
import 'package:dev_hub/features/workspace/domain/usecases/workspace_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart';
import '../domain/entity/github_repository_entity.dart';
part 'workspace_event.dart';
part 'workspace_state.dart';

class WorkspaceBloc extends Bloc<WorkspaceEvent, WorkspaceState> {
  final CreateWorkspaceUsecase _createWorkspaceUsecase;
  final GetWorkspaceUseCase _getWorkspaceUseCase;
  final GetRepositoriesUseCase _getRepositoriesUseCase;

  WorkspaceBloc({
    required CreateWorkspaceUsecase createWorkspaceUsecase,
    required GetWorkspaceUseCase getWorkspaceUseCase,
    required GetRepositoriesUseCase getRepositoriesUseCase,
  }) : _createWorkspaceUsecase = createWorkspaceUsecase,
       _getWorkspaceUseCase = getWorkspaceUseCase,
       _getRepositoriesUseCase = getRepositoriesUseCase,
       super(WorkspaceInitial()) {
    on<CreateWorkspaceEvent>((event, emit) async {
      emit(WorkspaceLoadingState());
      try {
        final response = await _createWorkspaceUsecase.call(event.params);
        response.fold(
          (error) => emit(WorkspaceFailure(error.message)),
          (workspace) => emit(WorkspaceCreated(workspace)),
        );
      } on Failure catch (error) {
        emit(WorkspaceFailure(error.message));
      } catch (e) {
        emit(WorkspaceFailure(e.toString()));
      }
    });

    on<WatchWorkspacesEvent>((event, emit) async {
      emit(WorkspaceLoadingState());
      final result = await _getWorkspaceUseCase.call(event.userId);

      await result.fold(
        (failure) async => emit(WorkspaceFailure(failure.message)),
        (stream) async {
          await emit.forEach<List<WorkspaceEntity>>(
            stream,
            onData: (workspaces) => WorkspaceLoaded(workspaces),
            onError: (error, stackTrace) => WorkspaceFailure(error.toString()),
          );
        },
      );
    });

    on<GetRepositoriesEvent>((event, emit) async {
      emit(RepositoriesLoading());
      final result = await _getRepositoriesUseCase.call(event.orgName);
      result.fold(
        (failure) => emit(RepositoriesFailure(failure.message)),
        (repositories) => emit(RepositoriesLoaded(repositories)),
      );
    });
  }
}
