import 'package:dev_hub/features/membership/data/model/invitation_model.dart';
import 'package:dev_hub/features/membership/data/model/member_model.dart';

abstract interface class MembershipFirestoreDatasource {
  Future<bool> createInvitation(InvitationModel invitation);

  Future<bool> addMember(MemberModel member);
}