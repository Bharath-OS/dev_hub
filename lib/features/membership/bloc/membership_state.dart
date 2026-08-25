part of 'membership_bloc.dart';

sealed class MembershipState extends Equatable {
  const MembershipState();
}

final class MembershipInitial extends MembershipState {
  @override
  List<Object> get props => [];
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
