import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_hub/core/constants/local_storage_keys.dart';
import 'package:dev_hub/core/constants/theme.dart';
import 'package:dev_hub/features/auth/domain/usecases/auth_usecases/auth_logout_usecase.dart';
import 'package:dev_hub/features/workspace/bloc/workspace_bloc.dart';
import 'package:dev_hub/features/workspace/data/Datasource/github_workspace_datasource.dart';
import 'package:dev_hub/features/workspace/data/Datasource/workspace_datasource.dart';
import 'package:dev_hub/features/workspace/data/repository/workspace_repository_impl.dart';
import 'package:dev_hub/features/workspace/domain/usecases/workspace_usecases.dart';
import 'package:dev_hub/firebase_options.dart';
import 'package:dev_hub/shared/data/datasources/local/secure_storage_impl.dart';
import 'package:dev_hub/shared/data/datasources/local/token_manager.dart';
import 'package:dev_hub/shared/data/datasources/remote/dio_client.dart';
import 'package:dev_hub/shared/data/datasources/remote/firestore_service.dart';
import 'package:dev_hub/shared/data/datasources/remote/github_api_data_source.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'features/auth/data/datasource/local/auth_local_database_impl.dart';
import 'features/auth/data/datasource/remote/auth_remote_data_source.dart';
import 'features/auth/data/datasource/remote/auth_remote_database_impl.dart';
import 'features/auth/data/repository/auth_repository_impl.dart';
import 'features/auth/data/repository/org_repository_impl.dart';
import 'features/auth/domain/usecases/auth_usecases/auth_usecase.dart';
import 'features/auth/domain/usecases/auth_usecases/check_log_in_usecase.dart';
import 'features/auth/domain/usecases/auth_usecases/get_current_user_usecase.dart';
import 'features/auth/domain/usecases/org_usecases/fetch_user_orgs_usecase.dart';
import 'features/auth/domain/usecases/org_usecases/update_organization_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/splash_screen.dart';

void main() async {
  final storage = FlutterSecureStorage(
    // aOptions: AndroidOptions.biometric(enforceBiometrics: true)
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final dio = Dio();
  final firestoreInstance = FirebaseFirestore.instance;
  final localDatabase = SecureStorageImpl(storage);

  //manages token across the app.
  final tokenManager = TokenManager(
    localDatabaseService: localDatabase,
    keys: LocalStorageKeys(),
  );

  final apiClient = DioClient(
    dio: dio,
    baseURL: "https://api.github.com/",
    tokenManager: tokenManager,
  );

  final githubApiDataSource = GithubApiDataSource(client: apiClient);

  final remoteDatabase = AuthRemoteDatabaseImpl(
    FirestoreService(firestoreInstance),
  );

  final workspaceRemoteDatabase = WorkspaceDatasourceImpl(
    firestoreService: FirestoreService(firestoreInstance),
  );

  final localDatabaseImpl = AuthLocalDatabaseImpl(
    db: localDatabase,
    keys: LocalStorageKeys(),
  );

  final authRepository = AuthRepositoryImpl(
    remoteDB: remoteDatabase,
    authService: AuthenticationImpl(FirebaseAuth.instance),
    localDB: localDatabaseImpl,
    firebaseAuth: FirebaseAuth.instance,
    tokenManager: tokenManager,
  );

  final orgRepository = OrgRepositoryImpl(
    githubApiDataSource: githubApiDataSource,
    remoteDB: remoteDatabase,
    localDB: localDatabaseImpl, tokenManager: tokenManager,
  );

  final workspaceRepository = WorkspaceRepositoryImpl(
    dataSource: workspaceRemoteDatabase,
    githubApiService: GithubWorkspaceDataSourceImpl(apiClient),
    tokenManager: tokenManager,
  );

  final authUseCase = AuthUseCase(authRepository);
  final fetchUserOrgsUseCase = FetchUserOrgsUseCase(orgRepository);
  final getCurrentUserUseCase = GetCurrentUserUseCase(authRepository);
  final updateOrganizationUseCase = UpdateOrganizationUseCase(orgRepository);
  final checkLoginUseCase = CheckLogInUsecase(authRepository);
  final createWorkspaceUseCase = CreateWorkspaceUsecase(
    WorkspaceRepositoryImpl(
      tokenManager: tokenManager,
      dataSource: WorkspaceDatasourceImpl(
        firestoreService: FirestoreService(firestoreInstance),
      ),
      githubApiService: GithubWorkspaceDataSourceImpl(apiClient),
    ),
  );
  final logoutUseCase = AuthLogoutUseCase(authRepository);
  final getWorkspacesUseCase = GetWorkspaceUseCase(workspaceRepository);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            authUseCase,
            fetchUserOrgsUseCase,
            getCurrentUserUseCase,
            updateOrganizationUseCase,
            checkLoginUseCase,
            logoutUseCase,
          ),
        ),
        BlocProvider(
          create: (_) => WorkspaceBloc(
            createWorkspaceUsecase: createWorkspaceUseCase,
            getWorkspaceUseCase: getWorkspacesUseCase,
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
