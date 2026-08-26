abstract class MemberEntity {
  final String uid;
  final String memberName;
  final String githubUsername;
  final String memberAvatarUrl;
  final String memberEmail;
  final String role; //'admin', 'lead', 'developer'
  final String? invitedBy; //uid of the admin
  final DateTime joinedAt;
  MemberEntity({
    required this.uid,
    required this.memberName,
    required this.memberEmail,
    required this.memberAvatarUrl,
    required this.role,
    required this.joinedAt,
    required this.githubUsername,
    this.invitedBy,
  });
}
