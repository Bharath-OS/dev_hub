import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/core/usecases/usecase.dart';
import 'package:fpdart/fpdart.dart';

//pass the username, repo name and organization name and it will return a boolean value whether the process is success or failure.
class AddRepoCollaboratorUseCase implements UseCase<void, String> {
  @override
  Future<Either<Failure, void>> call(String params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
