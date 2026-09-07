import 'package:dev_hub/features/membership/domain/entity/invitation_entity.dart';
import 'package:dev_hub/features/membership/domain/entity/member_entity.dart';

sealed class InviteMemberResult{}

class MemberAddedSuccess extends InviteMemberResult {
  final MemberEntity member;
  MemberAddedSuccess(this.member);
}

class InvitationSentSuccess extends InviteMemberResult{
  final InvitationEntity invitation;
  InvitationSentSuccess(this.invitation);
}