import '../../../../core/constants/repo_roles.dart';

class InvitedUserEntity {
  final int inviteeId;
  final String username;
  final String fullName;
  final String avatarUrl;
  RepoRoles role; // e.g. 'Developer', 'Team Lead'

  InvitedUserEntity({
    required this.inviteeId,
    required this.username,
    required this.fullName,
    required this.avatarUrl,
    this.role = RepoRoles.developer,
  });
}
