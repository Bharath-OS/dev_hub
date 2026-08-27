import 'package:dev_hub/features/membership/data/model/invitation_model.dart';
import 'package:dev_hub/features/membership/data/model/member_model.dart';
import 'package:dev_hub/features/membership/domain/entity/invitation_entity.dart';
import 'package:dev_hub/features/membership/domain/entity/member_entity.dart';

abstract interface class MembershipFirestoreDatasource {
  Future<InvitationModel> createInvitation(InvitationModel invitation);

  Future<MemberModel> addMember(MemberModel member);
}