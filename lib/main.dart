import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_hub/core/constants/local_storage_keys.dart';
import 'package:dev_hub/core/constants/theme.dart';
import 'package:dev_hub/data/datasources/remote/dio_client.dart';
import 'package:dev_hub/data/datasources/remote/github_api_data_source.dart';
import 'package:dev_hub/presentation/auth/data/datasource/local/auth_local_database_impl.dart';
import 'package:dev_hub/presentation/auth/data/datasource/remote/auth_remote_data_source.dart';
import 'package:dev_hub/presentation/auth/data/datasource/remote/auth_remote_database_impl.dart';
import 'package:dev_hub/presentation/auth/data/repository/auth_repository_impl.dart';
import 'package:dev_hub/presentation/auth/data/repository/org_repository_impl.dart';
import 'package:dev_hub/presentation/auth/domain/usecases/auth_usecases/auth_usecase.dart';
import 'package:dev_hub/presentation/auth/domain/usecases/auth_usecases/check_log_in_usecase.dart';
import 'package:dev_hub/presentation/auth/domain/usecases/auth_usecases/get_current_user_usecase.dart';
import 'package:dev_hub/presentation/auth/domain/usecases/org_usecases/fetch_user_orgs_usecase.dart';
import 'package:dev_hub/presentation/auth/domain/usecases/org_usecases/update_organization_usecase.dart';
import 'package:dev_hub/presentation/auth/pages/splash_screen.dart';
import 'package:dev_hub/firebase_options.dart';
import 'package:dev_hub/presentation/bloc/auth/auth_bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'data/datasources/local/secure_storage_impl.dart';
import 'data/datasources/remote/firestore_service.dart';

void main() async {
  final storage = FlutterSecureStorage(
    // aOptions: AndroidOptions.biometric(enforceBiometrics: true)
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final dio = Dio();
  final localDatabase = SecureStorageImpl(storage);
  final githubApiDataSource = GithubApiDataSource(
    client: DioClient(
      dio: dio,
      baseURL: "https://api.github.com/",
      localDB: AuthLocalDatabaseImpl(
        db: SecureStorageImpl(storage),
        keys: LocalStorageKeys(),
      ),
    ),
  );

  final remoteDatabase = AuthRemoteDatabaseImpl(
    FirestoreService(FirebaseFirestore.instance),
  );

  final localDatabaseImpl = AuthLocalDatabaseImpl(db: localDatabase, keys: LocalStorageKeys());

  final authRepository = AuthRepositoryImpl(
    remoteDB: remoteDatabase,
    authService: AuthenticationImpl(FirebaseAuth.instance),
    localDB: localDatabaseImpl,
    firebaseAuth: FirebaseAuth.instance,
  );

  final orgRepository = OrgRepositoryImpl(
    githubApiDataSource: githubApiDataSource,
    remoteDB: remoteDatabase,
    localDB: localDatabaseImpl
  );

  final authUseCase = AuthUseCase(authRepository);
  final fetchUserOrgsUseCase = FetchUserOrgsUseCase(orgRepository);
  final getCurrentUserUseCase = GetCurrentUserUseCase(authRepository);
  final updateOrganizationUseCase = UpdateOrganizationUseCase(orgRepository);
  final checkLoginUseCase = CheckLogInUsecase(authRepository);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            authUseCase,
            fetchUserOrgsUseCase,
            getCurrentUserUseCase,
            updateOrganizationUseCase,
            checkLoginUseCase
          ),
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
