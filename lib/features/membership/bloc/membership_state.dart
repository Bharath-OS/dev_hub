part of 'membership_bloc.dart';

sealed class MembershipState extends Equatable {
  const MembershipState();
}

final class MembershipInitial extends MembershipState {
  @override
  List<Object> get props => [];
}

final class SearchFailureState extends MembershipState{
  final String error;
  const SearchFailureState(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

final class SearchingUsersState extends MembershipState {
  const SearchingUsersState();

  @override
  List<Object?> get props => [];
}

final class NoUsersFoundState extends MembershipState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class UsersFoundState extends MembershipState {
  final List<InvitedUserEntity> users;

  const UsersFoundState(this.users);

  @override
  // TODO: implement props
  List<Object?> get props => [users];
}
