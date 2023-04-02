import 'package:auto_route/auto_route.dart';
import 'package:bloc_project/core/router.gr.dart';
import 'package:bloc_project/core/utils/shared_prefs.dart';
import 'package:bloc_project/main.dart';
import 'package:bloc_project/presentation/bloc/movie_cubit/movie_cubit.dart';
import 'package:bloc_project/presentation/bloc/moviedetail_cubit/moviedetail_cubit.dart';
import 'package:bloc_project/presentation/widgets/movie_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class MovieHomeScreen extends StatefulWidget {
  const MovieHomeScreen({Key? key}) : super(key: key);

  @override
  State<MovieHomeScreen> createState() => _MovieHomeScreenState();
}

class _MovieHomeScreenState extends State<MovieHomeScreen>
    with TickerProviderStateMixin {
  late MovieCubit _movieCubit;
  late MovieDetailCubit _moviedetailCubit;
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    setAppBarTitle();

    _moviedetailCubit = getIt<MovieDetailCubit>();
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
    return BlocListener<MovieDetailCubit, MovieDetailState>(
      bloc: _moviedetailCubit,
      listener: (context, state) {
        if (state is MovieDetailsFetched) {
          final movieDetailModel = state.movieDetailsModel;
          // context
          //     .pushRoute(MovieDetailRoute(movieDetailsModel: movieDetailModel));

          context.router
              .push(MovieDetailRoute(movieDetailsModel: movieDetailModel));

          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => MovieDetailScreen(
          //           movieDetailsModel: movieDetailModel,
          //         )));
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          //   value: const SystemUiOverlayStyle(
          //   statusBarColor: Colors.black, // status bar color
          //   statusBarIconBrightness: Brightness.dark, //status bar icons' color
          // systemNavigationBarColor: Colors.red, // navigation bar color
          // systemNavigationBarIconBrightness:
          //     Brightness.light, //navigation bar icons' color
          // ),
          preferredSize: const Size.fromHeight(100),

          child: Container(
            color: Colors.black87,
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
                          fontSize: 25,
                        ),
                      ),
                    ),
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
                  padding: const EdgeInsets.all(5.0),
                  child: TabBar(
                    indicatorWeight: 1,
                    //isScrollable: true,
                    indicator: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.green,
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    controller: _tabController,
                    tabs: const [
                      Text('Upcoming', style: TextStyle(fontSize: 20)),
                      Text('Popular', style: TextStyle(fontSize: 20)),
                      Text('Top Rated', style: TextStyle(fontSize: 20)),
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
          //   systemOverlayStyle: const SystemUiOverlayStyle(
          //     Control battery %,network status,notifications
          //      statusBarColor: Color.fromARGB(255, 41, 41, 41),
          //      statusBarIconBrightness: Brightness.light,
          //     statusBarColor: Colors.black,
          //     statusBarIconBrightness: Brightness.dark,
          //   ),
          // ),
        ),
        body: Container(
          color: Colors.black87,
          child: TabBarView(
            controller: _tabController,
            children: [
              Expanded(
                child: BlocBuilder<MovieCubit, MovieState>(
                    bloc: _movieCubit,
                    builder: (context, state) {
                      if (state is MovieFetched) {
                        return MovieListWidget(
                          movieFetched: state,
                          onClick: (int movieId) {
                            _moviedetailCubit.getMovieDetails(movieId: movieId);
                          },
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ),
              const Text("TAB2 "),
              const Text("TAB3"),
            ],
          ),
        ),
      ),
    );
  }
}

void setAppBarTitle() {
  PreferenceUtils.setString('titleBarKey', 'OUR MOVIE APP');
}
