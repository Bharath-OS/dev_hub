import '../../domain/entity/workspace_entity.dart';

class WorkspaceModel extends WorkspaceEntity {
  WorkspaceModel({
    required super.name,
    required super.id,
    required super.orgId,
    required super.githubOrgLogin,
    required super.adminId,
    super.description,
    super.createdAt,
    super.updatedAt
  });

  factory WorkspaceModel.fromFirestore(Map<String, dynamic> data) {
    return WorkspaceModel(
      name: data['Name'],
      id: data['Id'],
      description: data['Description'],
      orgId: data['Organization Id'],
      githubOrgLogin: data['Organization Name'],
      adminId: data['Admin Id'],
      createdAt: data['Created At'],
      updatedAt: data['Updated At']
    );
  }

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'Id': super.id,
      'Name': super.name,
      'Description': super.description,
      'Organization Id': super.orgId,
      'Organization Name': super.githubOrgLogin,
      'Admin Id': super.adminId,
      'Created At': super.createdAt,
      'Updated At': super.updatedAt,
    };
  }
}
