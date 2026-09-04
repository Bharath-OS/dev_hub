part of 'workspace_action_bloc.dart';

sealed class WorkspaceActionState extends Equatable {
  const WorkspaceActionState();
}

final class WorkspaceActionInitial extends WorkspaceActionState {
  @override
  List<Object> get props => [];
}

final class WorkspaceActionLoading extends WorkspaceActionState{
  const WorkspaceActionLoading();

  @override
  List<Object?> get props => [];
}

abstract class WorkspaceDisplayState extends WorkspaceActionState{
  final List<WorkspaceEntity> workspaces;
  const WorkspaceDisplayState(this.workspaces);

  @override
  List<Object?> get props => [workspaces];
}

final class WorkspaceCreated extends WorkspaceDisplayState{
  final WorkspaceEntity workspace;
  const WorkspaceCreated(this.workspace,super.workspaces);
}

final class WorkspaceActionFailure extends WorkspaceActionState{
  final String error;
  const WorkspaceActionFailure(this.error);

  @override
  List<Object?> get props => [error];
}

final class WorkspaceDeletedState extends WorkspaceActionState{
  const WorkspaceDeletedState();

  @override
  List<Object?> get props => [];
}

final class WorkspaceEditedState extends WorkspaceActionState{
  final WorkspaceEntity workspace;
  const WorkspaceEditedState(this.workspace);

  @override
  List<Object?> get props => [workspace];
}
