// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:bloc_project/presentation/screens/movie_detail_screen.dart'
    as _i1;
import 'package:bloc_project/presentation/screens/movie_home_screen.dart'
    as _i2;
import 'package:flutter/material.dart' as _i4;

abstract class $AppRouter extends _i3.RootStackRouter {
  $AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    MovieDetailRoute.name: (routeData) {
      final args = routeData.argsAs<MovieDetailRouteArgs>();
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.MovieDetailScreen(
          key: args.key,
          movieDetailsModel: args.movieDetailsModel,
        ),
      );
    },
    MovieHomeRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.MovieHomeScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.MovieDetailScreen]
class MovieDetailRoute extends _i3.PageRouteInfo<MovieDetailRouteArgs> {
  MovieDetailRoute({
    _i4.Key? key,
    required dynamic movieDetailsModel,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          MovieDetailRoute.name,
          args: MovieDetailRouteArgs(
            key: key,
            movieDetailsModel: movieDetailsModel,
          ),
          initialChildren: children,
        );

  static const String name = 'MovieDetailRoute';

  static const _i3.PageInfo<MovieDetailRouteArgs> page =
      _i3.PageInfo<MovieDetailRouteArgs>(name);
}

class MovieDetailRouteArgs {
  const MovieDetailRouteArgs({
    this.key,
    required this.movieDetailsModel,
  });

  final _i4.Key? key;

  final dynamic movieDetailsModel;

  @override
  String toString() {
    return 'MovieDetailRouteArgs{key: $key, movieDetailsModel: $movieDetailsModel}';
  }
}

/// generated route for
/// [_i2.MovieHomeScreen]
class MovieHomeRoute extends _i3.PageRouteInfo<void> {
  const MovieHomeRoute({List<_i3.PageRouteInfo>? children})
      : super(
          MovieHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'MovieHomeRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}
