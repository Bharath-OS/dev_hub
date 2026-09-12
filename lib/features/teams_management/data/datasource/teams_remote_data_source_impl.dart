import 'package:dev_hub/core/params/firestore_params.dart';
import 'package:dev_hub/features/teams_management/data/model/team_model.dart';
import 'package:dev_hub/features/teams_management/domain/entity/team_entity.dart';
import 'package:dev_hub/shared/data/datasources/remote/firestore_service.dart';

abstract interface class TeamsRemoteDataSource {
  Future<TeamModel> createTeam(TeamModel team);

  Future<void> deleteTeam({required String workspaceId, required int teamId});

  Future<Stream<List<TeamEntity>>> getTeams(String workspaceId);

  Future<void> updateTeam({
    required String workspaceId,
    required int teamId,
    required Map<String, dynamic> data,
  });
}

class TeamsRemoteDataSourceImpl implements TeamsRemoteDataSource {
  final FirestoreService _remoteDatabaseService;
  final String _teamCollectionName = 'Teams';
  TeamsRemoteDataSourceImpl(this._remoteDatabaseService);

  @override
  Future<TeamModel> createTeam(TeamModel team) async {
    try {
      await _remoteDatabaseService.create(
        FirestoreParams(
          collectionPath: "Workspaces/${team.workspaceId}/Teams",
          id: team.id.toString(),
          data: team.toMap(),
        ),
      );
      return team;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Stream<List<TeamEntity>>> getTeams(String workspaceId) async {
    return _remoteDatabaseService
        .readAll(
          FirestoreParams(
            collectionPath: 'Workspaces/$workspaceId/$_teamCollectionName',
          ),
        )
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return TeamModel.fromMap(doc.data());
          }).toList();
        });
  }

  @override
  Future<void> deleteTeam({
    required String workspaceId,
    required int teamId,
  }) async {
    return await _remoteDatabaseService.delete(
      FirestoreParams(
        collectionPath: 'Workspaces/$workspaceId/$_teamCollectionName',
        id: teamId.toString(),
      ),
    );
  }

  @override
  Future<void> updateTeam({
    required String workspaceId,
    required int teamId,
    required Map<String, dynamic> data,
  }) async {
    await _remoteDatabaseService.update(
      FirestoreParams(
        collectionPath: 'Workspaces/$workspaceId/$_teamCollectionName',
        id: teamId.toString(),
        data: data,
      ),
    );
  }
}
