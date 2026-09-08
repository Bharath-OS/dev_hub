abstract class TeamEntity {
  final String id;
  final String workspaceId;
  final String orgName;
  final String name;
  final String description;
  final String avatarUrl;
  final String privacy;
  final String permission;
  final int memberCount;
  final int repoCount;
  final int githubTeamId;
  final String githubTeamSlug;
  final String githubRepoName;
  final String githubRepoFullName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> membersIds;
  final List<String> teamLeadIds;
  TeamEntity({
    required this.id,
    required this.workspaceId,
    required this.name,
    required this.description,
    required this.avatarUrl,
    required this.githubTeamId,
    required this.githubTeamSlug,
    required this.githubRepoName,
    required this.githubRepoFullName,
    required this.createdAt,
    required this.updatedAt,
    required this.membersIds,
    required this.teamLeadIds,
    required this.orgName,
    required this.privacy,
    required this.permission,
    required this.memberCount,
    required this.repoCount,
  });
}
