class WorkspaceEntity {
  final String id;
  final String name;
  final String description;
  final String? avatarUrl;
  final String orgId;
  final String githubOrgLogin;
  final String repositoryName;
  final String adminId;
  final DateTime createdAt;
  final DateTime updatedAt;

  WorkspaceEntity({
    required this.name,
    this.description = '',
    required this.id,
    this.avatarUrl,
    required this.orgId,
    required this.githubOrgLogin,
    required this.repositoryName,
    required this.adminId,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();
}

class WorkspaceParams {
  final String id;
  final String name;
  final String? description;
  final String? avatarUrl;
  final String orgId;
  final String githubOrgLogin;
  final String repositoryName;
  final String adminId;
  final DateTime createdAt;
  final DateTime updatedAt;

  WorkspaceParams({
    required this.name,
    this.description,
    required this.id,
    this.avatarUrl,
    required this.orgId,
    required this.githubOrgLogin,
    required this.repositoryName,
    required this.adminId,
    required this.createdAt,
    required this.updatedAt,
  });
}
