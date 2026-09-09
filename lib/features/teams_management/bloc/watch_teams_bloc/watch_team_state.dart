part of 'watch_team_bloc.dart';

sealed class WatchTeamState extends Equatable {
  const WatchTeamState();
}

final class WatchTeamInitial extends WatchTeamState {
  @override
  List<Object> get props => [];
}

final class WatchTeamsFailure extends WatchTeamState{
  final String message;
  const WatchTeamsFailure(this.message);

  @override
  List<Object?> get props => [message];
}

final class TeamsLoadingState extends WatchTeamState{
  @override
  List<Object?> get props => [];
}

final class TeamLoaded extends WatchTeamState{
  final List<TeamEntity> teams;

  const TeamLoaded(this.teams);
  @override
  List<Object?> get props => [teams];
}
