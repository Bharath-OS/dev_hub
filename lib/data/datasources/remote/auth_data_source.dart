import 'package:dev_hub/domain/repository/auth/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/errors/failures.dart';

abstract interface class AuthRemoteDataSource{
  Future<UserCredential> githubAuthentication();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{
  @override
  Future<UserCredential> githubAuthentication() async {
    // TODO: implement githubAuthentication
    final githubProvider = GithubAuthProvider();
    return await FirebaseAuth.instance.signInWithProvider(githubProvider);
  }

}