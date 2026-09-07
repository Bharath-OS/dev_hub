import 'package:dev_hub/features/membership/domain/entity/member_entity.dart';

class WorkspaceEntity {
  final String id;
  final String name;
  final String description;
  final String? avatarUrl;
  final String orgId;
  final String githubOrgLogin;
  final String repositoryName;
  final String adminId;
  final List<String> adminUids;
  final List<String> memberUids;
  List<MemberEntity> members;
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
    List<String>? adminUids,
    List<String>? memberUids,
    this.members = const[],
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : adminUids = adminUids ?? [adminId],
        memberUids = memberUids ?? [adminId],
        createdAt = createdAt ?? DateTime.now(),
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
  final List<String> adminUids;
  final List<String> memberUids;
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
    List<String>? adminUids,
    List<String>? memberUids,
    required this.createdAt,
    required this.updatedAt,
  })  : adminUids = adminUids ?? [adminId],
        memberUids = memberUids ?? [adminId];
}
