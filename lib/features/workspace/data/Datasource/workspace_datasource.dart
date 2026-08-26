import 'package:dev_hub/core/params/firestore_params.dart';
import 'package:flutter/cupertino.dart';
import '../../../../shared/data/datasources/remote/firestore_service.dart';
import '../../domain/entity/workspace_entity.dart';
import '../model/workspace_model.dart';

abstract interface class WorkspaceDataSource {
  //create workspace method
  Future<WorkspaceModel> createWorkspace(WorkspaceParams params);

  Stream<List<WorkspaceEntity>> getWorkspaceStream(String userId);

  Future<WorkspaceModel> updateWorkspace(WorkspaceParams params);
}

class WorkspaceDatasourceImpl implements WorkspaceDataSource {
  final FirestoreService _firestoreService;
  final String collectionPath = 'Workspaces';
  WorkspaceDatasourceImpl({required this._firestoreService});

  @override
  Future<WorkspaceModel> createWorkspace(WorkspaceParams params) async {
    final workspace = WorkspaceModel(
      name: params.name,
      id: params.id,
      orgId: params.orgId,
      githubOrgLogin: params.githubOrgLogin,
      repositoryName: params.repositoryName,
      adminId: params.adminId,
    );
    try {
      await _firestoreService.create(
        FirestoreParams(
          collectionPath: collectionPath,
          id: workspace.id,
          data: workspace.toFirestore(),
        ),
      );
      return workspace;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Stream<List<WorkspaceEntity>> getWorkspaceStream(String userId) {
    return _firestoreService
        .readAll(
          FirestoreParams(
            collectionPath: collectionPath,
            queryField: 'Admin Id',
            queryValue: userId,
          ),
        )
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            debugPrint(doc.data().toString());
            return WorkspaceModel.fromFirestore(doc.data());
          }).toList();
        });
  }

  @override
  Future<WorkspaceModel> updateWorkspace(WorkspaceParams params) async {
    final updatedWorkspaceModel = WorkspaceModel(
      name: params.name,
      id: params.id,
      orgId: params.orgId,
      githubOrgLogin: params.githubOrgLogin,
      repositoryName: params.repositoryName,
      adminId: params.adminId,
    );
    try {
      await _firestoreService.update(
        FirestoreParams(
          collectionPath: collectionPath,
          id: updatedWorkspaceModel.id,
          data: updatedWorkspaceModel.toFirestore(),
        ),
      );
      return updatedWorkspaceModel;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
