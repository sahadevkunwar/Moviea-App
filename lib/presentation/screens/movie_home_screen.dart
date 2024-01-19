import 'package:auto_route/auto_route.dart';
import 'package:bloc_project/core/router.gr.dart';
import 'package:bloc_project/core/utils/hive_storage.dart';
import 'package:bloc_project/core/utils/shared_prefs.dart';
import 'package:bloc_project/main.dart';
import 'package:bloc_project/presentation/bloc/logout_cubit/logout_cubit.dart';
import 'package:bloc_project/presentation/bloc/movie_cubit/movie_cubit.dart';
import 'package:bloc_project/presentation/bloc/moviedetail_cubit/moviedetail_cubit.dart';
import 'package:bloc_project/presentation/widgets/movie_list_widget.dart';
import 'package:floating_snackbar/floating_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/themes/theme_cubit/theme_cubit.dart';

@RoutePage()
class MovieHomeScreen extends StatefulWidget {
  const MovieHomeScreen({Key? key}) : super(key: key);

  @override
  State<MovieHomeScreen> createState() => _MovieHomeScreenState();
}

class _MovieHomeScreenState extends State<MovieHomeScreen>
    with TickerProviderStateMixin {
  late MovieCubit _movieCubit;
  late MovieDetailCubit _movieDetailCubit;
  late TabController _tabController;
  late LogoutCubit _logoutCubit;

  // late ThemeCubit themeCubit;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    setAppBarTitle();
    // themeCubit = getIt<ThemeCubit>();
    _logoutCubit = getIt<LogoutCubit>();
    _movieDetailCubit = getIt<MovieDetailCubit>();
    _movieCubit = getIt<MovieCubit>()
      ..getUpcomingMovies(
          apiUrl:
              'http://api.themoviedb.org/3/movie/upcoming?api_key=caebc202bd0a26f84f4e0d986beb15cd');
    // _movieCubit.getUpcomingMovies(
    //     apiUrl:
    //         'http://api.themoviedb.org/3/movie/upcoming?api_key=caebc202bd0a26f84f4e0d986beb15cd');
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MovieDetailCubit, MovieDetailState>(
          bloc: _movieDetailCubit,
          listener: (context, state) {
            if (state is MovieDetailsFetched) {
              final movieDetailModel = state.movieDetailsModel;

              context.router
                  .push(MovieDetailRoute(movieDetailsModel: movieDetailModel));

              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => MovieDetailScreen(
              //           movieDetailsModel: movieDetailModel,
              //         )));
            } else if (state is MovieDetailError) {
              FloatingSnackBar(
                message: state.error,
                context: context,
                backgroundColor: Colors.red,
                textColor: Colors.white,
              );
            }
          },
        ),
        BlocListener<LogoutCubit, LogoutState>(
          bloc: _logoutCubit,
          listener: (context, state) {
            state.maybeWhen(
                orElse: () {},
                success: () {
                  context.router.replaceAll([const LoginRoute()]);
                });
          },
        ),
        BlocListener<MovieCubit, MovieState>(listener: (context, state) {
          if (state is MovieError) {
            // ScaffoldMessenger.of(context)
            //     .showSnackBar(SnackBar(content: Text(state.message)));
            FloatingSnackBar(
              message: state.message,
              context: context,
              textColor: Colors.white,
              backgroundColor: Colors.red,
              textStyle: const TextStyle(color: Colors.white),
              duration: const Duration(milliseconds: 4000),
            );
          }
        }),
      ],
      child: Scaffold(
        appBar: PreferredSize(
          //   value: const SystemUiOverlayStyle(
          //   statusBarColor: Colors.black, // status bar color
          //   statusBarIconBrightness: Brightness.dark, //status bar icons' color
          // systemNavigationBarColor: Colors.red, // navigation bar color
          // systemNavigationBarIconBrightness:
          //     Brightness.light, //navigation bar icons' color
          // ),
          preferredSize: const Size.fromHeight(120),

          child: Container(
            color: Colors.black54,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "WATCH NOW",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 27,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // themeCubit.toggleTheme();
                        getIt<ThemeCubit>().toggleTheme();
                      },
                      icon: BlocBuilder<ThemeCubit, ThemeData>(
                        builder: (context, theme) {
                          return Icon(
                            theme == ThemeCubit.lightTheme
                                ? Icons.dark_mode
                                : Icons.light_mode,
                          );
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        HiveUtils.fetchMovies();
                        // HiveUtils.fetchSingleMovie();
                        context.router.push(const BookmarkedMovieRoute());
                      },
                      icon: const Icon(
                        Icons.bookmark_add,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          _logoutCubit.logoutUser();
                        },
                        icon: const Icon(Icons.logout, color: Colors.white)),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () =>
                            context.router.push(const MovieSearchRoute()),
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: TabBar(
                    onTap: (index) {
                      if (index == 0) {
                        _movieCubit.getUpcomingMovies(
                            apiUrl:
                                'http://api.themoviedb.org/3/movie/upcoming?api_key=caebc202bd0a26f84f4e0d986beb15cd');
                      } else if (index == 1) {
                        _movieCubit.getUpcomingMovies(
                            apiUrl:
                                'http://api.themoviedb.org/3/movie/popular?api_key=caebc202bd0a26f84f4e0d986beb15cd');
                      } else if (index == 2) {
                        _movieCubit.getUpcomingMovies(
                            apiUrl:
                                'http://api.themoviedb.org/3/movie/top_rated?api_key=caebc202bd0a26f84f4e0d986beb15cd');
                      }
                    },
                    indicatorWeight: 1,
                    isScrollable: true,
                    indicator: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Color(0xff7052ff),
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    controller: _tabController,
                    tabs: const [
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text('Upcoming',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text('Popular',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text('Top Rated',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          // child: AppBar(
          //   bottom: const TabBar(
          //     indicatorWeight: 1,
          //     isScrollable: true,
          //     indicator: BoxDecoration(
          //       shape: BoxShape.rectangle,
          //       color: Colors.green,
          //       borderRadius: BorderRadius.all(
          //         Radius.circular(25),
          //       ),
          //     ),
          //     tabs: [
          //       Tab(child: Text('Populars', style: TextStyle(fontSize: 17))),
          //       Tab(child: Text('Coming Soon', style: TextStyle(fontSize: 17))),
          //       Tab(child: Text('Top Rated', style: TextStyle(fontSize: 17))),
          //       Tab(child: Text('Trending', style: TextStyle(fontSize: 17))),
          //       Tab(child: Text('High Rated', style: TextStyle(fontSize: 17))),
          //     ],
          //   ),
          //   backgroundColor: const Color.fromARGB(255, 15, 15, 15),
          //   title: Padding(
          //     padding: const EdgeInsets.only(top: 30),
          //     child: Row(
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         const Text('Watch Now', style: TextStyle(fontSize: 30)),
          //         IconButton(
          //             onPressed: () {},
          //             icon: const Icon(CupertinoIcons.search, size: 30.0))
          //       ],
          //     ),
          //   ),

          // ),
        ),
        body: Container(
          color: Colors.black54,
          child: TabBarView(
            controller: _tabController,
            children: [
              BuildMethod(
                  movieCubit: _movieCubit, moviedetailCubit: _movieDetailCubit),
              BuildMethod(
                  movieCubit: _movieCubit, moviedetailCubit: _movieDetailCubit),
              BuildMethod(
                  movieCubit: _movieCubit, moviedetailCubit: _movieDetailCubit),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildMethod extends StatelessWidget {
  const BuildMethod({
    super.key,
    required MovieCubit movieCubit,
    required MovieDetailCubit moviedetailCubit,
  })  : _movieCubit = movieCubit,
        _movieDetailCubit = moviedetailCubit;

  final MovieCubit _movieCubit;
  final MovieDetailCubit _movieDetailCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<MovieCubit, MovieState>(
              bloc: _movieCubit,
              builder: (context, state) {
                if (state is MovieFetched) {
                  return MovieListWidget(
                    movieFetched: state,
                    onClick: (int movieId) {
                      _movieDetailCubit.getMovieDetails(movieId: movieId);
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ],
    );
  }
}

void setAppBarTitle() {
  PreferenceUtils.setString('titleBarKey', 'OUR MOVIE APP');
}
