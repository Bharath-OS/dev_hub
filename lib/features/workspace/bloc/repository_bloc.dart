import 'package:dev_hub/features/workspace/domain/entity/github_repository_entity.dart';
import 'package:dev_hub/features/workspace/domain/usecases/workspace_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'repository_event.dart';
part 'repository_state.dart';

class RepositoryBloc extends Bloc<RepositoryEvent, RepositoryState> {
  final GetRepositoriesUseCase _getRepositoriesUseCase;

  RepositoryBloc({
    required GetRepositoriesUseCase getRepositoriesUseCase,
  }) : _getRepositoriesUseCase = getRepositoriesUseCase,
       super(RepositoriesInitial()) {
    on<GetRepositoriesEvent>((event, emit) async {
      emit(RepositoriesLoading());
      final result = await _getRepositoriesUseCase.call(event.orgName);
      result.fold(
        (failure) => emit(RepositoriesFailure(failure.message)),
        (repositories) => emit(RepositoriesLoaded(repositories)),
      );
    });
  }
}
