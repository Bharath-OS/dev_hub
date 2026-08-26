import 'package:dev_hub/core/params/firestore_params.dart';
import 'package:dev_hub/features/membership/data/data%20source/remote/membership_firestore_datasource.dart';
import 'package:dev_hub/features/membership/data/model/invitation_model.dart';
import 'package:dev_hub/shared/data/datasources/remote/firestore_service.dart';
import '../../model/member_model.dart';

class MembershipFirestoreDatasourceImpl
    implements MembershipFirestoreDatasource {
  final FirestoreService _firestoreService;

  MembershipFirestoreDatasourceImpl({required this._firestoreService});

  @override
  Future<bool> addMember(MemberModel member) async{
    try {
      final params = FirestoreParams(
        collectionPath:
        "Workspaces/${member.workspaceId}/Members",
        data: member.toFirestore(),
      );
      await _firestoreService.create(params);
      return true;
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  @override
  Future<bool> createInvitation(InvitationModel invitationDocument) async {
    try {
      final params = FirestoreParams(
        collectionPath:
            "Workspaces/${invitationDocument.workspaceId}/Invitations",
        data: invitationDocument.toFirestore(),
      );
      await _firestoreService.create(params);
      return true;
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
