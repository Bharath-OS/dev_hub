import 'package:dev_hub/features/teams_management/domain/entity/team_entity.dart';

class TeamModel extends TeamEntity {
  TeamModel({
    required super.id,
    required super.workspaceId,
    required super.orgName,
    required super.name,
    required super.description,
    required super.avatarUrl,
    required super.githubTeamId,
    required super.githubTeamSlug,
    required super.githubRepoName,
    required super.githubRepoFullName,
    required super.createdAt,
    required super.updatedAt,
    required super.membersIds,
    required super.teamLeadIds,
    required super.privacy,
    required super.permission,
    required super.memberCount,
    required super.repoCount,
  });

  TeamModel.fromMap(Map<String, dynamic> map)
    : super(
        id: map['team id'] ?? '',
        workspaceId: map['workspace id'] ?? '',
        name: map['name'] ?? map['team name'] ?? '',
        orgName: map['organization']['login'] ?? map['org name'] ?? '',
        description: map['description'] ?? map['team description'] ?? '',
        avatarUrl: map['avatar url'] ?? '',
        privacy: map['privacy'] ?? '',
        permission: map['permission'] ?? '',
        memberCount: map['members_count'] ?? map['members count'] ?? 0,
        repoCount: map['repos_count'] ?? map['repos count'] ?? 0,
        githubTeamId: map['id'] ?? map['github team id'] ?? 0,
        githubTeamSlug: map['slug'] ?? map['team slug'] ?? '',
        githubRepoName: map['linked repo name'] ?? '',
        githubRepoFullName: map['linked repo full name'] ?? '',
        createdAt: DateTime.parse(map['created_at'] ?? map['created at']),
        updatedAt: DateTime.parse(map['updated_at'] ?? map['updated at']),
        membersIds: map['members'] ?? [],
        teamLeadIds: map['team leads'] ?? [],
      );

  Map<String, dynamic> toMap(TeamModel team) {
    return <String, dynamic>{
      'team id': team.id,
      'workspace id': team.workspaceId,
      'team name': team.name,
      'org name': team.orgName,
      'team description': team.description,
      'avatar url': team.avatarUrl,
      'privacy' : team.privacy,
      'permission':team.permission,
      'members count': team.memberCount,
      'repos count':team.repoCount,
      'github team id': team.githubTeamId,
      'team slug': team.githubTeamSlug,
      'linked repo name': team.githubRepoName,
      'linked repo full name': team.githubRepoFullName,
      'created at': team.createdAt.toIso8601String(),
      'updated at': team.updatedAt.toIso8601String(),
      'member ids': team.membersIds,
      'team lead ids': teamLeadIds,
    };
  }
}
