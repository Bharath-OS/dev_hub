import 'package:dev_hub/core/params/firestore_params.dart';
import 'package:dev_hub/features/teams_management/data/model/team_model.dart';
import 'package:dev_hub/features/teams_management/domain/entity/team_entity.dart';
import 'package:dev_hub/shared/data/datasources/remote/firestore_service.dart';

import '../../params/team_params.dart';

abstract interface class TeamsRemoteDataSource {
  Future<TeamModel> createTeam(TeamModel team);

  Future<Stream<List<TeamEntity>>> getTeams(String workspaceId);
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
          id: team.id,
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
}
