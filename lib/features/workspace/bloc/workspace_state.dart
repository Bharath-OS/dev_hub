part of 'workspace_bloc.dart';

sealed class WorkspaceState extends Equatable {
  const WorkspaceState();
}

final class WorkspaceInitial extends WorkspaceState {
  @override
  List<Object> get props => [];
}

final class WorkspaceLoadingState extends WorkspaceState{
  @override
  List<Object?> get props => [];
}

abstract class WorkspaceDisplayState extends WorkspaceState{
  final List<WorkspaceEntity> workspaces;
  const WorkspaceDisplayState(this.workspaces);

  @override
  List<Object?> get props => [workspaces];
}

final class WorkspaceCreated extends WorkspaceDisplayState{
  final WorkspaceEntity workspace;
  const WorkspaceCreated(this.workspace,super.workspaces);
}

final class WorkspaceLoaded extends WorkspaceDisplayState {
  const WorkspaceLoaded(super.workspaces);
}

final class WorkspaceFailure extends WorkspaceState {
  final String error;
  const WorkspaceFailure(this.error);

  @override
  List<Object?> get props => [error];
}

