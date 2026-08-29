part of 'membership_bloc.dart';

sealed class MembershipEvent extends Equatable {
  const MembershipEvent();
}

class SearchUserEvent extends MembershipEvent {
  final String searchQuery;
  const SearchUserEvent(this.searchQuery);

  @override
  List<Object?> get props => [searchQuery];
}

class InviteMembersEvent extends MembershipEvent {
  final List<InvitedUserEntity> invitees;
  final WorkspaceEntity workspace;
  const InviteMembersEvent({required this.invitees, required this.workspace});

  @override
  List<Object?> get props => [invitees];
}
