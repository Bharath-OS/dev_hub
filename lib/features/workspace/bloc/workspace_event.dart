part of 'workspace_bloc.dart';

sealed class WorkspaceEvent extends Equatable {
  final WorkspaceParams params;
  const WorkspaceEvent(this.params);
}

class CreateWorkspaceEvent extends WorkspaceEvent{
  const CreateWorkspaceEvent(super.params);
  @override
  List<Object?> get props => [params];
}

class UpdateWorkspaceEvent extends WorkspaceEvent{
  const UpdateWorkspaceEvent(super.params);

  @override
  List<Object?> get props => [];
}
