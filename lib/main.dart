import 'package:dev_hub/core/constants/theme.dart';
import 'package:dev_hub/data/datasources/remote/auth_data_source.dart';
import 'package:dev_hub/data/repositories/auth_remote_repository_impl.dart';
import 'package:dev_hub/data/repositories/org_repository_impl.dart';
import 'package:dev_hub/domain/usecases/auth/auth_usecase.dart';
import 'package:dev_hub/domain/usecases/org/fetch_user_orgs_usecase.dart';
import 'package:dev_hub/firebase_options.dart';
import 'package:dev_hub/presentation/bloc/auth/auth_bloc.dart';
import 'package:dev_hub/presentation/pages/auth/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final authUseCase = AuthUseCase(AuthRepositoryImpl(AuthRemoteDataSourceImpl()));
  final fetchUserOrgsUseCase = FetchUserOrgsUseCase(OrgRepositoryImpl());

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_)=>AuthBloc(authUseCase, fetchUserOrgsUseCase))
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.appTheme,
      home: const SplashScreen()
    );
  }
}

