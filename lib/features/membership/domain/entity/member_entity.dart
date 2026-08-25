abstract class MemberEntity {
  final String uid;
  final String memberName;
  final String memberAvatarUrl;
  final String memberEmail;
  final String role;
  final DateTime joinedAt;
  MemberEntity({
    required this.uid,
    required this.memberName,
    required this.memberEmail,
    required this.memberAvatarUrl,
    required this.role,
    required this.joinedAt,
  });
}
