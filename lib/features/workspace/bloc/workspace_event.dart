part of 'workspace_bloc.dart';

sealed class WorkspaceEvent extends Equatable {
  const WorkspaceEvent();
}

class CreateWorkspaceEvent extends WorkspaceEvent {
  final WorkspaceParams params;
  const CreateWorkspaceEvent(this.params);
  @override
  List<Object?> get props => [params];
}

class UpdateWorkspaceEvent extends WorkspaceEvent {
  final WorkspaceParams params;
  const UpdateWorkspaceEvent(this.params);

  @override
  List<Object?> get props => [params];
}

class WatchWorkspacesEvent extends WorkspaceEvent {
  final String userId;
  const WatchWorkspacesEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}


class GetRepositoriesEvent extends WorkspaceEvent{
  final String orgName;
  const GetRepositoriesEvent(this.orgName);

  @override
  // TODO: implement props
  List<Object?> get props => [orgName];
}