/// User model for representation in search and selection
class InvitedUserEntity {
  final String id;
  final String username;
  final String fullName;
  final String avatarUrl;
  String role; // e.g. 'Developer', 'Team Lead'

  InvitedUserEntity({
    required this.id,
    required this.username,
    required this.fullName,
    required this.avatarUrl,
    this.role = 'Developer',
  });
}