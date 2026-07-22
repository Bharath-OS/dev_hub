import 'package:dev_hub/core/errors/failures.dart';
import 'package:dev_hub/data/datasources/remote/auth_data_source.dart';
import 'package:dev_hub/domain/repository/auth/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository{

  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failures, UserCredential>> githubAuthentication() async{
    try{
      final userCredential = await remoteDataSource.githubAuthentication();
      return right(userCredential);
    }catch(e){
        return left(Failures(e.toString()));
    }
  }
}