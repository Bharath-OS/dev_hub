import 'package:dev_hub/core/constants/theme.dart';
import 'package:dev_hub/data/datasources/remote/auth_data_source.dart';
import 'package:dev_hub/data/repositories/auth_remote_repository_impl.dart';
import 'package:dev_hub/domain/usecases/auth/auth_usecase.dart';
import 'package:dev_hub/firebase_options.dart';
import 'package:dev_hub/presentation/bloc/auth/auth_bloc.dart';
import 'package:dev_hub/presentation/pages/auth/register.dart';
import 'package:dev_hub/presentation/pages/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_)=>AuthBloc(AuthUseCase(AuthRepositoryImpl(AuthRemoteDataSourceImpl()))))
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
      home: AuthScreen()
    );
  }
}

