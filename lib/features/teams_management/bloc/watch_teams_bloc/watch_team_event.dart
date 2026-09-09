part of 'watch_team_bloc.dart';

sealed class WatchTeamEvent extends Equatable {
  const WatchTeamEvent();
}

class WatchAllTeamsEvent extends WatchTeamEvent {
  final String workspaceId;
  const WatchAllTeamsEvent(this.workspaceId);

  @override
  List<Object?> get props => [workspaceId];
}
