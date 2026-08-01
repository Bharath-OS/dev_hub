import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_hub/core/constants/theme.dart';
import 'package:dev_hub/data/datasources/local/local_data_source.dart';
import 'package:dev_hub/data/datasources/remote/dio_impl.dart';
import 'package:dev_hub/data/datasources/remote/github_api_data_source.dart';
import 'package:dev_hub/presentation/auth/data/datasource/local/local_datasource_impl.dart';
import 'package:dev_hub/presentation/auth/data/datasource/remote/auth_data_source.dart';
import 'package:dev_hub/presentation/auth/data/datasource/remote/auth_remote_datasource.dart';
import 'package:dev_hub/presentation/auth/data/repository/auth_remote_repository_impl.dart';
import 'package:dev_hub/presentation/auth/data/repository/org_repository_impl.dart';
import 'package:dev_hub/presentation/auth/domain/usecases/auth/auth_usecase.dart';
import 'package:dev_hub/presentation/auth/domain/usecases/org/fetch_user_orgs_usecase.dart';
import 'package:dev_hub/presentation/auth/pages/splash.dart';
import 'package:dev_hub/firebase_options.dart';
import 'package:dev_hub/presentation/bloc/auth/auth_bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'data/datasources/remote/firebase_firestore.dart';

void main() async {
  final storage = FlutterSecureStorage(
    // aOptions: AndroidOptions.biometric(enforceBiometrics: true)
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final authUseCase = AuthUseCase(
    AuthRepositoryImpl(
      remoteDB: AuthRemoteDatabaseImpl(
        FirestoreService(FirebaseFirestore.instance),
      ),
      authenticate: AuthenticationImpl(FirebaseAuth.instance),
      localDB: AuthLocalDataSourceImpl(SecureStorageImpl(storage)), githubApiService: GithubApiDataSource(services: ApiServices(Dio(), _githubToken)),
    ),
  );
  final fetchUserOrgsUseCase = FetchUserOrgsUseCase(OrgRepositoryImpl());

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(authUseCase, fetchUserOrgsUseCase),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.appTheme,
      home: const SplashScreen(),
    );
  }
}
