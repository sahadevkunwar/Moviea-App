import 'package:bloc_project/core/router.dart';
import 'package:bloc_project/core/utils/hive_storage.dart';
import 'package:bloc_project/core/utils/shared_prefs.dart';
import 'package:bloc_project/data/models/movie_card_model.dart';
import 'package:bloc_project/presentation/bloc/movie_cubit/movie_cubit.dart';
import 'package:bloc_project/presentation/bloc/movie_search_cubit/movie_search_cubit.dart';
import 'package:bloc_project/presentation/bloc/moviedetail_cubit/moviedetail_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/data_source/movie_data_source.dart';
import 'data/repository/movie_repository.dart';

GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MovieCardAdapter());
  await Hive.openBox('movieDB');
  getIt.registerLazySingleton<HiveUtils>(() => HiveUtils());
  getIt.registerLazySingleton<MovieCubit>(() => MovieCubit());
  getIt.registerLazySingleton<MovieDetailCubit>(() => MovieDetailCubit());
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<MovieSearchCubit>(() => MovieSearchCubit());
  getIt.registerLazySingleton<AppRouter>(() => AppRouter());
  getIt.registerLazySingleton<MovieRepository>(
      () => MovieRepository(MovieDataSource()));
  PreferenceUtils.init();
  await getIt<HiveUtils>().initDb();
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
