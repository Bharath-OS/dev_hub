import 'package:dev_hub/features/membership/domain/entity/invitation_entity.dart';

class InvitationModel extends InvitationEntity {
  final String uid;
  final String workspaceId;
  final String email;
  final String role;
  final String invitedBy;
  final DateTime sentAt;
  final String status; // 'pending', 'accepted', 'rejected'
  InvitationModel({
    required this.email,
    required this.role,
    required this.invitedBy,
    required this.sentAt,
    required this.status,
    required this.uid,
    required this.workspaceId,
  }) : super(
         email: email,
         role: role,
         invitedBy: invitedBy,
         sentAt: sentAt,
         status: status,
         uid: uid,
         workspaceId: workspaceId,
       );

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'Uid': uid,
      'Workspace Id': workspaceId,
      'Email': email,
      'Role': role,
      'Invited By': invitedBy,
      'Sent At': sentAt.toIso8601String(),
      'Status': status,
    };
  }
}
