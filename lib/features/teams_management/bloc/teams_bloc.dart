import 'package:dev_hub/features/teams_management/domain/usecases/create_team_usecase.dart';
import 'package:dev_hub/features/teams_management/domain/usecases/delete_team_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dev_hub/features/teams_management/domain/entity/team_entity.dart';
import 'package:equatable/equatable.dart';
import '../domain/usecases/update_team_use_case.dart';
import '../params/team_params.dart';

part 'teams_event.dart';
part 'teams_state.dart';

class TeamsBloc extends Bloc<TeamsEvent, TeamsState> {
  final CreateTeamUseCase _createTeamUseCase;
  final DeleteTeamUseCase _deleteTeamUseCase;
  final UpdateTeamUseCase _updateTeamUseCase;

  TeamsBloc({
    required this._createTeamUseCase,
    required this._deleteTeamUseCase,
    required this._updateTeamUseCase,
  }) : super(TeamsInitial()) {
    on<CreateTeamEvent>((event, emit) async {
      emit(LoadingState());
      try {
        final result = await _createTeamUseCase.call(
          TeamParams(
            orgName: event.orgName,
            workspaceId: event.workspaceId,
            name: event.teamName,
            description: event.description,
            githubRepoFullName: event.repoFullName,
          ),
        );
        result.fold(
          (failure) => emit(TeamFailure(failure.message)),
          (team) => emit(TeamCreatedState(team)),
        );
      } catch (e) {
        emit(TeamFailure(e.toString()));
      }
    });

    on<DeleteTeamEvent>((event, emit) async {
      emit(LoadingState());
      try {
        final result = await _deleteTeamUseCase.call(
          TeamParams(
            orgName: event.orgName,
            githubTeamSlug: event.teamSlug,
            workspaceId: event.workspaceId,
            id: event.teamId
          ),
        );
        result.fold(
          (failure) => emit(TeamFailure(failure.message)),
          (success) => emit(TeamDeletedState()),
        );
      } catch (e) {
        emit(TeamFailure(e.toString()));
      }
    });

    bool _checkForUpdates(
      TeamEntity originalTeamEntity,
      TeamParams teamUpdates,
    ) {
      //In future, decided to add more fields for editing.
      Map<String, dynamic> map = {
        if (originalTeamEntity.name != teamUpdates.name)
          "name": teamUpdates.name,
        if (originalTeamEntity.description != teamUpdates.description)
          "description": teamUpdates.description,
        if (originalTeamEntity.privacy != teamUpdates.privacy!.name)
          "privacy": teamUpdates.privacy,
        if (originalTeamEntity.permission != teamUpdates.permission!.name)
          "permission": teamUpdates.permission!.name,
      };
      return map.isEmpty;
    }

    //updating team event
    on<UpdateTeamEvent>((event, emit) async {
      final teamParams = TeamParams(
        name: event.teamName,
        description: event.teamDescription,
        orgName: event.orgName,
        githubTeamSlug: event.teamSlug,
        originalTeamEntity: event.originalTeamEntity,
      );
      final didTeamDataChanged = _checkForUpdates(
        event.originalTeamEntity,
        teamParams,
      );
      if (didTeamDataChanged) {
        emit(TeamFailure('No changes detected.'));
        return;
      }
      emit(LoadingState());
      try {
        final result = await _updateTeamUseCase.call(teamParams);
        result.fold(
          (failure) => emit(TeamFailure(failure.message)),
          (updatedTeam) => emit(TeamUpdatedState()),
        );
      } catch (e) {
        emit(TeamFailure(e.toString()));
      }
    });
  }
}
