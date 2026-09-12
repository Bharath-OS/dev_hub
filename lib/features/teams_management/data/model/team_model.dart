import 'package:dev_hub/features/teams_management/domain/entity/team_entity.dart';

class TeamModel extends TeamEntity {
  TeamModel({
    required super.id,
    required super.workspaceId,
    required super.orgName,
    required super.name,
    required super.description,
    required super.avatarUrl,
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
        id: map['id'] ?? 0,
        workspaceId: map['workspace id'] ?? '',
        name: map['name'] ?? map['team name'] ?? '',
        orgName: map['organization']?['login'] ?? map['org name'] ?? '',
        description: map['description'] ?? map['team description'] ?? '',
        avatarUrl: map['avatar url'] ?? '',
        privacy: map['privacy'] ?? '',
        permission: map['permission'] ?? '',
        memberCount: map['members_count'] ?? map['members count'] ?? 0,
        repoCount: map['repos_count'] ?? map['repos count'] ?? 0,
        githubTeamSlug: map['slug'] ?? map['team slug'] ?? '',
        githubRepoName: map['linked repo name'] ?? '',
        githubRepoFullName: map['linked repo full name'] ?? '',
        createdAt: DateTime.parse(map['created_at'] ?? map['created at']),
        updatedAt: DateTime.parse(map['updated_at'] ?? map['updated at']),
        membersIds: map['members'] ?? [],
        teamLeadIds: map['team leads'] ?? [],
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'workspace id': workspaceId,
      'name': name,
      'org name': orgName,
      'description': description,
      'avatar url': avatarUrl,
      'privacy': privacy,
      'permission': permission,
      'members count': memberCount,
      'repos count': repoCount,
      'team slug': githubTeamSlug,
      'linked repo name': githubRepoName,
      'linked repo full name': githubRepoFullName,
      'created at': createdAt.toIso8601String(),
      'updated at': updatedAt.toIso8601String(),
      'member ids': membersIds,
      'team lead ids': teamLeadIds,
    };
  }

  TeamModel copyWith({
    int? id,
    String? workspaceId,
    String? orgName,
    String? name,
    String? description,
    String? avatarUrl,
    String? privacy,
    String? permission,
    int? memberCount,
    int? repoCount,
    int? githubTeamId,
    String? githubTeamSlug,
    String? githubRepoName,
    String? githubRepoFullName,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? membersIds,
    List<String>? teamLeadIds,
  }) {
    return TeamModel(
      id: id ?? this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      orgName: orgName ?? this.orgName,
      name: name ?? this.name,
      description: description ?? this.description,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      githubTeamSlug: githubTeamSlug ?? this.githubTeamSlug,
      githubRepoName: githubRepoName ?? this.githubRepoName,
      githubRepoFullName: githubRepoFullName ?? this.githubRepoFullName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      membersIds: membersIds ?? this.membersIds,
      teamLeadIds: teamLeadIds ?? this.teamLeadIds,
      privacy: privacy ?? this.privacy,
      permission: permission ?? this.permission,
      memberCount: memberCount ?? this.memberCount,
      repoCount: repoCount ?? this.repoCount,
    );
  }
}
