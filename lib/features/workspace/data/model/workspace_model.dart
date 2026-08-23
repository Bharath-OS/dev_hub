import '../../domain/entity/workspace_entity.dart';

class WorkspaceModel extends WorkspaceEntity {
  WorkspaceModel({
    required super.name,
    required super.id,
    required super.orgId,
    required super.githubOrgLogin,
    required super.repositoryName,
    required super.adminId,
    super.description,
    super.createdAt,
    super.updatedAt,
  });

  factory WorkspaceModel.fromFirestore(Map<String, dynamic> data) {
    return WorkspaceModel(
      name: data['Name'],
      id: data['Id'],
      description: data['Description'] ?? '',
      orgId: data['Organization Id'],
      githubOrgLogin: data['Organization Name'],
      repositoryName: data['Repository Name'] ?? '',
      adminId: data['Admin Id'],
      createdAt: data['Created At'] != null ? DateTime.parse(data['Created At']) : null,
      updatedAt: data['Updated At'] != null ? DateTime.parse(data['Updated At']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'Id': super.id,
      'Name': super.name,
      'Description': super.description,
      'Organization Id': super.orgId,
      'Organization Name': super.githubOrgLogin,
      'Repository Name': super.repositoryName,
      'Admin Id': super.adminId,
      'Created At': super.createdAt.toIso8601String(),
      'Updated At': super.updatedAt.toIso8601String(),
    };
  }
}
