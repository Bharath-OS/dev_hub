import 'package:dev_hub/data/datasources/remote/github_api_data_source.dart';
import 'package:dev_hub/domain/repository/auth/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import '../../models/user_model.dart';

abstract interface class AuthRemoteDataSource{
  Future<UserModel> authenticate();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl();
  
  @override
  Future<UserModel> authenticate() async {
    final githubProvider = GithubAuthProvider();

    // Scopes for all roles
    githubProvider.addScope('user');        // basic profile
    githubProvider.addScope('read:org');    // org membership info
    githubProvider.addScope('repo');        // issues, milestones, repos
    githubProvider.addScope('admin:org');   // manage org members & teams

    // Prompt user to select account each time
    githubProvider.setCustomParameters({'prompt': 'select_account'});

    final credential = await FirebaseAuth.instance.signInWithProvider(githubProvider);


    if (credential.user == null) {
      throw Exception("Authentication failed");
    }

    // Access token for GitHub API calls
    final token = credential.credential?.accessToken;
    print("GitHub access token: $token");

    // Basic GitHub profile info
    print("GitHub profile JSON: ${credential.additionalUserInfo?.profile}");

    // Authorization code (if available)
    print("GitHub authorization code: ${credential.additionalUserInfo?.authorizationCode}");

    return UserModel.fromRemoteSource(credential: credential);
  }
}

