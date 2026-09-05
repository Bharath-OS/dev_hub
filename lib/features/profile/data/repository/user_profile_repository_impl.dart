import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/features/auth/data/models/user_model.dart';
import 'package:dev_hub/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:dev_hub/features/profile/domain/params/user_params.dart';
import 'package:fpdart/fpdart.dart';

import '../../../auth/data/datasource/remote/auth_remote_database_interface.dart';
import '../../domain/repository/user_profile_repository.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;
  final AuthRemoteDatabaseInterface _remoteDatabase;

  UserProfileRepositoryImpl({
    required ProfileRemoteDataSource remoteDataSource,
    required AuthRemoteDatabaseInterface remoteDatabase,
  })  : _remoteDataSource = remoteDataSource,
        _remoteDatabase = remoteDatabase;

  @override
  Future<Either<Failure, UserModel>> editUserDetails(UserParams params) async {
    try {
      if (params.userName == null) {
        return Left(Failure('Username is required'));
      }

      final userModel = await _remoteDataSource.updateDisplayName(
        newDisplayName: params.userName!,
      );

      await _remoteDatabase.updateUser(
        userId: userModel.id,
        fields: {'displayName': params.userName},
      );

      return Right(userModel);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
