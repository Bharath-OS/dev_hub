import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/data/datasources/remote/auth_data_source.dart';
import 'package:dev_hub/domain/entities/user_entity.dart';
import 'package:dev_hub/domain/repository/auth/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository{

  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failures, UserEntity>> githubAuthentication() async{
    try{
      final userModel = await remoteDataSource.authenticate();
      return right(userModel);
    }catch(e){
        return left(Failures(e.toString()));
    }
  }
}