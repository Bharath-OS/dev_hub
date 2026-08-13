import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/features/auth/domain/entities/user_entity.dart';

import 'package:fpdart/src/either.dart';

import '../../../../core/usecases/usecase.dart';

class UpdatePersonalInfoUsecase implements UseCase<String, UserProfileParams>{
  @override
  Future<Either<Failure, String>> call(UserProfileParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }

}

class UserProfileParams{
  final UserEntity currentUser;
  final String? name;
  final String? email;
  final String? username;
  final String? profilePictureUrl;
  UserProfileParams({required this.currentUser,this.name, this.username, this.email, this.profilePictureUrl});
}