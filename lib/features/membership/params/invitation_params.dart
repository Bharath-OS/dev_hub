import 'package:dev_hub/core/constants/org_roles.dart';
import 'package:dev_hub/features/membership/data/model/member_model.dart';
import 'package:dev_hub/features/membership/domain/entity/member_entity.dart';
import '../../../core/constants/repo_roles.dart';
import '../data/model/invitation_model.dart';
import '../domain/entity/invitation_entity.dart';

class InvitationParams {
  final String? uid;
  final int? inviteeId;
  final String? workspaceId;
  final RepoRoles? repoRole;
  final OrgRoles orgRole;
  final String? ownerName;
  final String? userName;
  final String? orgName;
  final String? repoName;
  final String? invitedBy;
  InvitationParams({
    this.uid,
    this.userName,
    this.orgName,
    this.repoName,
    this.workspaceId,
    this.orgRole = OrgRoles.member,
    this.ownerName,
    this.inviteeId,
    this.repoRole,
    this.invitedBy,
  });

  static InvitationModel toInvitationModel(InvitationEntity invitation) {
    return InvitationModel(
      email: invitation.email,
      role: invitation.role,
      invitedBy: invitation.invitedBy,
      sentAt: invitation.sentAt,
      status: invitation.status,
      uid: invitation.uid,
      workspaceId: invitation.workspaceId,
      orgName: invitation.orgName,
      inviteeId: invitation.inviteeId,
    );
  }

  static MemberModel toMemberModel(MemberEntity member) {
    return MemberModel(
      uid: member.uid,
      memberName: member.memberName,
      memberEmail: member.memberEmail,
      memberAvatarUrl: member.memberAvatarUrl,
      role: member.role,
      joinedAt: member.joinedAt,
      githubUsername: member.githubUsername,
      workspaceId: member.workspaceId,
      invitedBy: member.invitedBy,
    );
  }
}
