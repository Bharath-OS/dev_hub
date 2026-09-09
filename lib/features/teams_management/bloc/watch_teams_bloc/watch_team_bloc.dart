import 'package:dev_hub/features/teams_management/domain/usecases/get_teams_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entity/team_entity.dart';

part 'watch_team_event.dart';
part 'watch_team_state.dart';

class WatchTeamBloc extends Bloc<WatchTeamEvent, WatchTeamState> {
  final GetTeamsUseCase _getTeamsUseCase;
  List<TeamEntity> _currentTeams = [];

  WatchTeamBloc(this._getTeamsUseCase) : super(WatchTeamInitial()) {
    on<WatchAllTeamsEvent>((event, emit) async {
      emit(TeamsLoadingState());
      final result = await _getTeamsUseCase.call(event.workspaceId);
      result.fold((failure) => emit(WatchTeamsFailure(failure.message)), (
        stream,
      ) async {
        await emit.forEach<List<TeamEntity>>(
          stream,
          onData: (teams) {
            _currentTeams = teams;
            return TeamLoaded(teams);
          },
          onError: (error, _)=>WatchTeamsFailure(error.toString())
        );
      });
    });
  }
}
