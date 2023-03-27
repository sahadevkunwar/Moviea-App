import 'package:bloc_project/core/router.dart';
import 'package:bloc_project/presentation/bloc/movie_cubit/movie_cubit.dart';
import 'package:bloc_project/presentation/bloc/moviedetail_cubit/moviedetail_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void main() {
  getIt.registerLazySingleton<MovieCubit>(() => MovieCubit());
  getIt.registerLazySingleton<MovieDetailCubit>(() => MovieDetailCubit());
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<AppRouter>(() => AppRouter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AppRouter _appRouter = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _appRouter.config(),
    );
  }
}
