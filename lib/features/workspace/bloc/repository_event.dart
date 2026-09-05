part of 'repository_bloc.dart';

sealed class RepositoryEvent extends Equatable {
  const RepositoryEvent();
}

class GetRepositoriesEvent extends RepositoryEvent {
  final String orgName;
  const GetRepositoriesEvent(this.orgName);

  @override
  List<Object?> get props => [orgName];
}
