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
      TeamParams teamParams,
    ) {
      //In future, decided to add more fields for editing.
      Map<String, dynamic> map = {
        if (teamParams.originalTeamEntity!.name != teamParams.name)
          "name": teamParams.name,
        if (teamParams.originalTeamEntity!.description != teamParams.description)
          "description": teamParams.description,
        // if (teamParams.originalTeamEntity!.privacy != teamParams.privacy!.name)
        //   "privacy": teamParams.privacy,
        // if (teamParams.originalTeamEntity!.permission != teamParams.permission!.name)
        //   "permission": teamParams.permission!.name,
      };
      return map.isNotEmpty;
    }

    //updating team event
    on<UpdateTeamEvent>((event, emit) async {
      final teamParams = TeamParams(
        id: event.originalTeamEntity.id,
        workspaceId: event.originalTeamEntity.workspaceId,
        name: event.teamName ?? event.originalTeamEntity.name,
        description: event.teamDescription ?? event.originalTeamEntity.description,
        orgName: event.orgName ?? event.originalTeamEntity.orgName,
        githubTeamSlug: event.teamSlug ?? event.originalTeamEntity.githubTeamSlug,
        originalTeamEntity: event.originalTeamEntity,
        privacy: event.privacy,
        permission: event.permission,
      );
      final didTeamDataChanged = _checkForUpdates(
        teamParams,
      );
      if (!didTeamDataChanged) {
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
