part of 'membership_bloc.dart';

sealed class MembershipState extends Equatable {
  const MembershipState();
}

final class MembershipInitial extends MembershipState {
  @override
  List<Object> get props => [];
}

final class SearchFailureState extends MembershipState {
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

abstract class InvitationStates extends MembershipState {}

class InvitingMembersState extends InvitationStates {
  @override
  List<Object?> get props => [];
}

class InviteFailureState extends MembershipState {
  final String message;
  const InviteFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class InviteMemberSuccess extends MembershipState {
  final int successCount;
  final int failureCount;
  final List<InviteeInviteResult> results;

  const InviteMemberSuccess({
    required this.results,
    required this.successCount,
    required this.failureCount,
  });
  @override
  List<Object?> get props => [results, successCount, failureCount];
}
