import 'package:dev_hub/features/membership/domain/entity/member_entity.dart';

class MemberModel extends MemberEntity {
  MemberModel({
    required super.uid,
    required super.memberName,
    required super.memberEmail,
    required super.memberAvatarUrl,
    required super.role,
    required super.joinedAt,
    required super.githubUsername,
    required super.workspaceId,
  });

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'Id': super.uid,
      'Workspace Id': super.workspaceId,
      'Member Name': super.memberName,
      'GitHub Username': super.githubUsername,
      'Member Email': super.memberEmail,
      'Avatar Url': super.memberAvatarUrl,
      'Role': super.role,
      'Joined At': super.joinedAt.toIso8601String(),
    };
  }
}
