import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> authenticate();

  Future<void> signOut();
}

class AuthenticationImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  AuthenticationImpl(this._firebaseAuth);

  @override
  Future<UserModel> authenticate() async {
    final githubProvider = GithubAuthProvider();

    // Scopes for all roles
    githubProvider.addScope('user'); // basic profile
    githubProvider.addScope('read:org'); // org membership info
    githubProvider.addScope('repo'); // issues, milestones, repos
    githubProvider.addScope('admin:org'); // manage org members & teams

    // Prompt user to select account each time
    githubProvider.setCustomParameters({'prompt': 'select_account'});

    final credential = await _firebaseAuth.signInWithProvider(
      githubProvider,
    );

    if (credential.user == null) {
      throw Exception("Authentication failed");
    }

    // Access token for GitHub API calls
    final token = credential.credential?.accessToken;
    debugPrint("GitHub access token: $token");

    // Basic GitHub profile info
    debugPrint("GitHub profile JSON: ${credential.additionalUserInfo?.profile}");

    return UserModel.fromRemoteSource(credential: credential);
  }

  @override
  Future<void> signOut() async{
    await _firebaseAuth.signOut();
  }

}
