import 'package:dev_hub/core/usecases/usecase.dart';
import '../../repository/auth_repository.dart';

class CheckLogInUsecase{
  final AuthRepository _repo;
  CheckLogInUsecase(this._repo);

  Future<bool> call(NoParams params) async {
   return await _repo.isLoggedIn();
  }

}