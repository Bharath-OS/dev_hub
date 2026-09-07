part of 'workspace_action_bloc.dart';

sealed class WorkspaceActionEvent extends Equatable {
  const WorkspaceActionEvent();
}

class DeleteWorkspaceEvent extends WorkspaceActionEvent {
  final WorkspaceEntity workspace;
  const DeleteWorkspaceEvent(this.workspace);

  @override
  List<Object?> get props => [workspace];
}

class CreateWorkspaceEvent extends WorkspaceActionEvent {
  final WorkspaceParams params;
  const CreateWorkspaceEvent(this.params);

  @override
  List<Object?> get props => [params];
}

class ModifyWorkspaceEvent extends WorkspaceActionEvent {
  final WorkspaceParams params;
  const ModifyWorkspaceEvent(this.params);

  @override
  List<Object?> get props => [params];
}
