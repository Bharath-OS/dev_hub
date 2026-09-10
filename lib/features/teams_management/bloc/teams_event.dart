part of 'teams_bloc.dart';

sealed class TeamsEvent extends Equatable {
  const TeamsEvent();
}

final class CreateTeamEvent extends TeamsEvent {
  final String workspaceId;
  final String orgName;
  final String teamName;
  final String? description;
  final String repoFullName;
  final Privacy? privacy;
  final Permission? permission;
  const CreateTeamEvent({
    required this.orgName,
    required this.teamName,
    required this.repoFullName,
    this.description,
    this.privacy,
    this.permission, required this.workspaceId,
  });

  @override
  List<Object?> get props => [
    orgName,
    teamName,
    repoFullName,
    privacy,
    permission,
    description,
    workspaceId
  ];
}

final class DeleteTeamEvent extends TeamsEvent {
  final String orgName;
  final String teamSlug;
  const DeleteTeamEvent({required this.orgName, required this.teamSlug});

  @override
  List<Object?> get props => [orgName, teamSlug];
}

final class UpdateTeamEvent extends TeamsEvent {
  final String? orgName;
  final String? teamSlug;
  final String? teamName;
  final String? teamDescription;
  final Privacy? privacy;
  final Permission? permission;

  const UpdateTeamEvent(
    this.orgName,
    this.teamSlug,
    this.teamName,
    this.teamDescription,
    this.privacy,
    this.permission,
  );

  @override
  List<Object?> get props => [
    orgName,
    teamSlug,
    teamName,
    teamDescription,
    privacy,
    permission,
  ];
}

final class GetATeamByName extends TeamsEvent{
  final String orgName;
  final String teamSlug;
  const GetATeamByName({required this.orgName, required this.teamSlug});

  @override
  List<Object?> get props => [orgName, teamSlug];
}
