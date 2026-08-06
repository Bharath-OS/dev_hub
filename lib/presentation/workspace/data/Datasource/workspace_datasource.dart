import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_hub/core/params/firestore_params.dart';
import '../../../../../data/datasources/remote/firestore_service.dart';
import '../../domain/entity/workspace_entity.dart';
import '../model/workspace_model.dart';

abstract interface class WorkspaceDataSource {
  //create workspace method
  Future<void> createWorkspace(WorkspaceEntity params);

  Stream<QuerySnapshot<Map<String, dynamic>>> getWorkspaceStream();
}

class WorkspaceDatasourceImpl implements WorkspaceDataSource {
  final FirestoreService _firestoreService;
  final String collectionPath = 'Workspaces';
  WorkspaceDatasourceImpl(this._firestoreService);

  @override
  Future<void> createWorkspace(WorkspaceEntity params) async {
    final workspace = WorkspaceModel(
      name: params.name,
      id: params.id,
      orgId: params.orgId,
      githubOrgLogin: params.githubOrgLogin,
      adminId: params.adminId,
    );
    try {
      await _firestoreService.create(
        FirestoreParams(
          collectionPath: collectionPath,
          data: workspace.toFirestore(),
        ),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getWorkspaceStream() {
    return _firestoreService.readAll(
      FirestoreParams(collectionPath: collectionPath),
    );
  }
}
