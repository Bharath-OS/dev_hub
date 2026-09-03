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

  Future<void> deleteWorkspace(String workspaceId) async {}
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
      adminUids: params.adminUids,
      memberUids: params.memberUids,
    );
    try {
      await _firestoreService.create(
        FirestoreParams(
          collectionPath: collectionPath,
          id: workspace.id,
          data: workspace.toMap(),
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
            arrayContainsField: 'memberUids',
            arrayContainsValue: userId,
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
          data: updatedWorkspaceModel.toMap(),
        ),
      );
      return updatedWorkspaceModel;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteWorkspace(String workspaceId) async {
    await _firestoreService.delete(
      FirestoreParams(collectionPath: collectionPath, id: workspaceId),
    );
  }
}
