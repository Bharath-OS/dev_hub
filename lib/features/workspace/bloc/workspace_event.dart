part of 'workspace_bloc.dart';

sealed class WorkspaceEvent extends Equatable {
  const WorkspaceEvent();
}

class CreateWorkspaceEvent extends WorkspaceEvent{
  final WorkspaceParams _params;

  const CreateWorkspaceEvent(this._params);
  @override
  List<Object?> get props => [_params];
}

class UpdateWorkspaceEvent extends WorkspaceEvent{
  final WorkspaceParams _params;
  const UpdateWorkspaceEvent(this._params);

  @override
  List<Object?> get props => [_params];
}

class InviteMembersEvent extends WorkspaceEvent{
  final List<String> _members;

  const InviteMembersEvent(this._members);
  @override
  List<Object?> get props => [_members];

}
