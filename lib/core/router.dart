import 'package:auto_route/auto_route.dart';
import 'package:bloc_project/core/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: MovieHomeRoute.page, path: '/movieHomeRoute'),
        AutoRoute(page: LoginRoute.page, path: '/loginRoute'),
        AutoRoute(page: SplashRoute.page, path: '/'),
        AutoRoute(page: RegisterRoute.page, path: '/registerRoute'),
        AutoRoute(page: MovieDetailRoute.page, path: '/movieDetailRoute'),
        AutoRoute(page: MovieSearchRoute.page, path: '/movieSearchRoute'),
        AutoRoute(
            page: BookmarkedMovieRoute.page, path: '/bookmarkedMovieRoute'),
      ];
}
