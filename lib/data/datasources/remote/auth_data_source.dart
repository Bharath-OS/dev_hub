import 'package:dev_hub/domain/repository/auth/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/errors/failures.dart';
import '../../models/user_model.dart';

abstract interface class AuthRemoteDataSource{
  Future<UserModel> authenticate();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{
  @override
  Future<UserModel> authenticate() async {
    final githubProvider = GithubAuthProvider();
    final credential = await FirebaseAuth.instance.signInWithProvider(githubProvider);
    if(credential.user == null){
      throw Exception("Authentication failed");
    }
    return UserModel.fromRemoteSource(credential);
  }
}