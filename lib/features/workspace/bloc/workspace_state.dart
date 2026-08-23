part of 'workspace_bloc.dart';

sealed class WorkspaceState extends Equatable {
  const WorkspaceState();
}

final class WorkspaceInitial extends WorkspaceState {
  @override
  List<Object> get props => [];
}

final class WorkspaceLoadingState extends WorkspaceState{
  @override
  List<Object?> get props => [];
}

final class WorkspaceCreated extends WorkspaceState{
  final WorkspaceEntity workspaceEntity;
  const WorkspaceCreated(this.workspaceEntity);

  @override
  List<Object?> get props => [workspaceEntity];
}

final class WorkspaceLoaded extends WorkspaceState {
  final List<WorkspaceEntity> workspaces;
  const WorkspaceLoaded(this.workspaces);

  @override
  List<Object?> get props => [workspaces];
}

final class WorkspaceFailure extends WorkspaceState {
  final String error;
  const WorkspaceFailure(this.error);

  @override
  List<Object?> get props => [error];
}

final class RepositoriesLoading extends WorkspaceState {
  @override
  List<Object?> get props => [];
}

final class RepositoriesLoaded extends WorkspaceState {
  final List<GitHubRepositoryEntity> repositories;
  const RepositoriesLoaded(this.repositories);

  @override
  List<Object?> get props => [repositories];
}

final class RepositoriesFailure extends WorkspaceState {
  final String error;
  const RepositoriesFailure(this.error);

  @override
  List<Object?> get props => [error];
}

