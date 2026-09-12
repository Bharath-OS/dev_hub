part of 'teams_bloc.dart';

sealed class TeamsState extends Equatable {
  const TeamsState();
}

final class TeamsInitial extends TeamsState {
  @override
  List<Object> get props => [];
}

final class TeamCreatedState extends TeamsState {
  final TeamEntity team;
  const TeamCreatedState(this.team);

  @override
  List<Object?> get props => [team];
}

final class LoadingState extends TeamsState {
  @override
  List<Object?> get props => [];
}

class TeamFailure extends TeamsState {
  final String message;
  const TeamFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class TeamSuccess extends TeamsState{
  final TeamEntity team;
  const TeamSuccess(this.team);

  @override
  List<Object?> get props => [team];
}

class TeamDeletedState extends TeamsState{
  @override
  List<Object?> get props => [];
}

class TeamUpdatedState extends TeamsState{
  @override
  List<Object?> get props => [];
}