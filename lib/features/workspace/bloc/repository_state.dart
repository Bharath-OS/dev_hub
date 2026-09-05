part of 'repository_bloc.dart';

sealed class RepositoryState extends Equatable {
  const RepositoryState();
}

final class RepositoriesInitial extends RepositoryState {
  @override
  List<Object?> get props => [];
}

final class RepositoriesLoading extends RepositoryState {
  @override
  List<Object?> get props => [];
}

final class RepositoriesLoaded extends RepositoryState {
  final List<GitHubRepositoryEntity> repositories;
  const RepositoriesLoaded(this.repositories);

  @override
  List<Object?> get props => [repositories];
}

final class RepositoriesFailure extends RepositoryState {
  final String error;
  const RepositoriesFailure(this.error);

  @override
  List<Object?> get props => [error];
}
