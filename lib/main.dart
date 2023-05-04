import 'package:bloc_project/bootstrap.dart';
import 'package:bloc_project/core/router.dart';
import 'package:bloc_project/core/router.gr.dart';
import 'package:bloc_project/feature/auth/presentation/blocs/app_bloc/app_cubit.dart';
import 'package:bloc_project/feature/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:bloc_project/presentation/bloc/movie_cubit/movie_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void main() async {
  await bootstrap();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRouter _appRouter = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<MovieCubit>(),
        ),
        BlocProvider(
          create: (context) =>
              getIt<AppCubit>()..checkIfUserIsLoggedInPreviouslY(),
        ),
      ],
      child: BlocListener<AppCubit, AppState>(
        listener: (context, state) {
          state.maybeWhen(
              orElse: () {},
              isLoggedIn: () {
                _appRouter.push(const MovieHomeRoute());
              },
              isNotLoggedIn: () {
                _appRouter.push(const LoginRoute());
              });
        },
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: _appRouter.config(),
        ),
      ),
    );
  }
}
