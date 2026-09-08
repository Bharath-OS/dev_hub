class TeamParams {
  final String? id;
  final String? workspaceId;
  final String? orgName;
  final String? name;
  final String? description;
  final String? avatarUrl;
  final int? githubTeamId;
  final String? githubTeamSlug;
  final String? githubRepoName;
  final String? githubRepoFullName;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<String>? membersIds;
  final List<String>? maintainers;
  final Privacy? privacy;
  final Permission? permission;
  TeamParams({
    this.id,
    this.workspaceId,
    this.name,
    this.description,
    this.avatarUrl,
    this.githubTeamId,
    this.githubTeamSlug,
    this.githubRepoName,
    this.githubRepoFullName,
    this.createdAt,
    this.updatedAt,
    this.membersIds,
    this.privacy = Privacy.secret,
    this.maintainers = const <String>[],
    this.orgName,
    this.permission = Permission.push,
  });
}

enum Privacy { secret, closed }

enum Permission { read, write, push, maintain, admin }
