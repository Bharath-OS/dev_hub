import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/features/membership/domain/repository/membership_repository.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/usecases/usecase.dart';

class SendOrgInvitationUseCase implements UseCase<void, String>{
  final MembershipRepository _repository;
  SendOrgInvitationUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await _repository.inviteUser('','');
  }
}