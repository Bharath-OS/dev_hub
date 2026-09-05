import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/user_entity.dart';

class AuthLogoutUseCase implements UseCase<void, NoParams>{
  final AuthRepository _repo;

  AuthLogoutUseCase(this._repo);

  @override
  Future<Either<Failure, void>> call(NoParams params) async{
    return await _repo.logOut();
  }

}