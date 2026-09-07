part of 'workspace_bloc.dart';

sealed class WorkspaceEvent extends Equatable {
  const WorkspaceEvent();
}

class WatchWorkspacesEvent extends WorkspaceEvent {
  final String userId;
  const WatchWorkspacesEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}