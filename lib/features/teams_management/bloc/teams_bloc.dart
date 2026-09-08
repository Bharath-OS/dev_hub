import 'package:dev_hub/features/teams_management/domain/usecases/create_team_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dev_hub/features/teams_management/domain/entity/team_entity.dart';
import 'package:equatable/equatable.dart';
import '../params/team_params.dart';

part 'teams_event.dart';
part 'teams_state.dart';

class TeamsBloc extends Bloc<TeamsEvent, TeamsState> {
  final CreateTeamUseCase _createTeamUseCase;

  TeamsBloc({required this._createTeamUseCase}) : super(TeamsInitial()) {
    on<CreateTeamEvent>((event, emit) async {
      emit(LoadingState());
      final result = await _createTeamUseCase.call(
        TeamParams(
          orgName: event.orgName,
          workspaceId: event.workspaceId,
          name: event.teamName,
          description: event.description,
          githubRepoFullName: event.repoName,
        ),
      );
      result.fold(
        (failure) => emit(TeamFailure(failure.message)),
        (team) => emit(TeamCreatedState(team)),
      );
    });
  }
}
