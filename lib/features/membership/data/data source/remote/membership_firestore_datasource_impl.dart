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
  Future<MemberModel> addMember(MemberModel member) async {
    try {
      final params = FirestoreParams(
        collectionPath: "Workspaces/${member.workspaceId}/Members",
        id: member.uid,
        data: member.toMap(),
      );
      await _firestoreService.create(params);
      // Keep the workspace's memberUids index in sync so the new member can
      // list the workspace via the memberUids array-contains query.
      await _firestoreService.addToArray(
        FirestoreParams(
          collectionPath: "Workspaces",
          id: member.workspaceId,
        ),
        array: 'memberUids',
        value: member.uid,
      );
      return member.copyWith(joinedAt: DateTime.now());
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  @override
  Future<InvitationModel> createInvitation(
    InvitationModel invitationDocument,
  ) async {
    try {
      final params = FirestoreParams(
        collectionPath:
            "Workspaces/${invitationDocument.workspaceId}/Invitations",
        data: invitationDocument.toMap(),
      );
      await _firestoreService.create(params);
      return invitationDocument.copyWith(sentAt: DateTime.now());
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
