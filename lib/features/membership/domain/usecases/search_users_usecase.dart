import 'package:dev_hub/features/membership/domain/entity/invited_user_entity.dart';
import 'package:dev_hub/features/membership/domain/repository/membership_repository.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';

class SearchUsersUseCase implements UseCase<List<InvitedUserEntity>, String>{
  final MembershipRepository _repository;

  SearchUsersUseCase(this._repository);

  @override
  Future<Either<Failure, List<InvitedUserEntity>>> call(String searchQuery) async {
    final response = await _repository.searchUser(searchQuery);
    return response;
  }
}