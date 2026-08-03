import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/data/datasources/remote/github_api_data_source.dart';
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasource/local/local_datasource_impl.dart';
import '../datasource/remote/auth_data_source.dart';
import '../datasource/remote/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository{

  final AuthRemoteDataSource authenticate;
  final AuthLocalDataSourceImpl localDB;
  final AuthRemoteDatabaseImpl remoteDB;
  final GithubApiDataSource githubApiService;

  AuthRepositoryImpl({required this.remoteDB,required this.authenticate,required this.localDB, required this.githubApiService});

  @override
  Future<Either<Failure, UserEntity>> githubAuthentication() async {
    try {
      final userModel = await authenticate.authenticate();
      final String? accessToken = userModel.githubAccessToken;

      if (accessToken == null || accessToken.isEmpty) {
        return left(Failure("GitHub authentication failed: Access token missing"));
      }

      await localDB.updateToken(accessToken: accessToken);

      final orgsResult = await githubApiService.getOrganizations(
        githubUsername: userModel.githubUsername,
        accessToken: accessToken,
      );

      return orgsResult.fold(
        (failure) => left(failure),
        (orgs) async {
          final updatedUser = userModel.copyWith(allOrganizations: orgs);
          await remoteDB.saveUser(user: updatedUser);
          return right(updatedUser);
        },
      );
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // @override
  // Future<Either<Failure, UserEntity?>> currentUser()async{
  //   try{
  //     final user = await remoteDB.getUser();
  //     return user;
  //   }catch(e){
  //     return left(Failure(e.toString()));
  //   }
  // }
}