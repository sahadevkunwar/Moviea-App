import 'package:bloc_project/core/router.dart';
import 'package:bloc_project/core/themes/theme_cubit/theme_cubit.dart';
import 'package:bloc_project/core/utils/hive_storage.dart';
import 'package:bloc_project/core/utils/shared_prefs.dart';
import 'package:bloc_project/data/data_source/logout_source.dart';
import 'package:bloc_project/data/models/movie_card_model.dart';
import 'package:bloc_project/data/repository/logout_repo_impl.dart';
import 'package:bloc_project/feature/auth/data/app_repo_impl.dart';
import 'package:bloc_project/feature/auth/presentation/blocs/app_bloc/app_cubit.dart';
import 'package:bloc_project/feature/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:bloc_project/feature/auth/source/app_source.dart';
import 'package:bloc_project/feature/auth/source/register_source.dart';
import 'package:bloc_project/presentation/bloc/logout_cubit/logout_cubit.dart';
import 'package:bloc_project/presentation/bloc/movie_cubit/movie_cubit.dart';
import 'package:bloc_project/presentation/bloc/movie_search_cubit/movie_search_cubit.dart';
import 'package:bloc_project/presentation/bloc/moviedetail_cubit/moviedetail_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/data_source/movie_data_source.dart';
import 'data/repository/movie_repository.dart';
import 'feature/auth/data/register_repo_impl.dart';

GetIt getIt = GetIt.instance;

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MovieCardAdapter());
  await Hive.openBox('movieDB');
  getIt.registerLazySingleton<HiveUtils>(() => HiveUtils());
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<AppRouter>(() => AppRouter());
  // getIt.registerLazySingleton<RegisterRepoImpl>(
  //     () => RegisterRepoImpl(RegisterSource(HiveUtils())));

  PreferenceUtils.init();
  await getIt<HiveUtils>().initDb();



  ///SOURCE SINGLETON
  getIt.registerLazySingleton<MovieRepository>(
      () => MovieRepository(MovieDataSource()));
  getIt.registerLazySingleton<AppSource>(() => AppSource(getIt<HiveUtils>()));
  getIt.registerLazySingleton<RegisterSource>(
      () => RegisterSource(getIt<HiveUtils>()));
  getIt.registerLazySingleton<LogoutDataSource>(
      () => LogoutDataSource(getIt<HiveUtils>()));

  ///REPO SINGLETON
  getIt.registerLazySingleton<RegisterRepoImpl>(
      () => RegisterRepoImpl(getIt<RegisterSource>()));
  getIt.registerLazySingleton<AppRepoImpl>(
      () => AppRepoImpl(getIt<AppSource>()));
  getIt.registerLazySingleton<LogoutRepoImpl>(
      () => LogoutRepoImpl(getIt<LogoutDataSource>()));

  ///CUBIT SINGLETON
  getIt.registerLazySingleton<AppCubit>(() => AppCubit(getIt<AppRepoImpl>()));
  getIt.registerLazySingleton<MovieCubit>(() => MovieCubit());
  getIt.registerLazySingleton<MovieDetailCubit>(() => MovieDetailCubit());
  getIt.registerLazySingleton<MovieSearchCubit>(() => MovieSearchCubit());
  getIt.registerLazySingleton<AuthBloc>(() => AuthBloc());
  getIt.registerLazySingleton<LogoutCubit>(
      () => LogoutCubit(getIt<LogoutRepoImpl>()));

  ///Theme singleton
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
}
