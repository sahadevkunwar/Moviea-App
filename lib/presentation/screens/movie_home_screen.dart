import 'package:auto_route/auto_route.dart';
import 'package:bloc_project/core/router.gr.dart';
import 'package:bloc_project/main.dart';
import 'package:bloc_project/presentation/bloc/movie_cubit/movie_cubit.dart';
import 'package:bloc_project/presentation/bloc/moviedetail_cubit/moviedetail_cubit.dart';
import 'package:bloc_project/presentation/widgets/movie_list_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class MovieHomeScreen extends StatefulWidget {
  const MovieHomeScreen({Key? key}) : super(key: key);

  @override
  State<MovieHomeScreen> createState() => _MovieHomeScreenState();
}

class _MovieHomeScreenState extends State<MovieHomeScreen> {
  late MovieCubit _movieCubit;
  late MovieDetailCubit _moviedetailCubit;
  @override
  void initState() {
    super.initState();
    _moviedetailCubit = getIt<MovieDetailCubit>();
    _movieCubit = getIt<MovieCubit>();
    getIt<MovieCubit>().getUpcomingMovies(
        apiUrl:
            'http://api.themoviedb.org/3/movie/upcoming?api_key=caebc202bd0a26f84f4e0d986beb15cd');
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MovieDetailCubit, MovieDetailState>(
      bloc: _moviedetailCubit,
      listener: (context, state) {
        if (state is MovieDetailsFetched) {
          final movieDetailModel = state.movieDetailsModel;
          context
              .pushRoute(MovieDetailRoute(movieDetailsModel: movieDetailModel));
          // context.router
          //     .push(MovieDetailRoute(movieDetailsModel: movieDetailModel));

          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => MovieDetailScreen(
          //           movieDetailsModel: movieDetailModel,
          //         )));
        }
      },
      child: DefaultTabController(
        length: 5,
        initialIndex: 1,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(130),
            child: AppBar(
              bottom: const TabBar(
                indicatorWeight: 0.1,
                isScrollable: true,
                indicator: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.green,
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                tabs: [
                  Tab(child: Text('Populars', style: TextStyle(fontSize: 17))),
                  Tab(
                      child:
                          Text('Coming Soon', style: TextStyle(fontSize: 17))),
                  Tab(child: Text('Top Rated', style: TextStyle(fontSize: 17))),
                  Tab(child: Text('Trending', style: TextStyle(fontSize: 17))),
                  Tab(
                      child:
                          Text('High Rated', style: TextStyle(fontSize: 17))),
                ],
              ),
              backgroundColor: const Color.fromARGB(255, 15, 15, 15),
              title: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Watch Now', style: TextStyle(fontSize: 30)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(CupertinoIcons.search_circle,
                            size: 30.0))
                  ],
                ),
              ),
              systemOverlayStyle: const SystemUiOverlayStyle(
                //Control battery %,network status,notifications
                // statusBarColor: Color.fromARGB(255, 41, 41, 41),
                // statusBarIconBrightness: Brightness.light,
                statusBarColor: Colors.black,
                statusBarIconBrightness: Brightness.dark,
              ),
            ),
          ),
          body: Center(
            child: Container(
              decoration: const BoxDecoration(color: Colors.black87),
              //  color: const Color.fromARGB(255, 41, 41, 41),
              child: Column(
                children: [
                  Expanded(
                    child: BlocBuilder<MovieCubit, MovieState>(
                        bloc: _movieCubit,
                        builder: (context, state) {
                          if (state is MovieFetched) {
                            return MovieListWidget(
                              movieFetched: state,
                              onClick: (int movieId) {
                                _moviedetailCubit.getMovieDetails(
                                    movieId: movieId);
                              },
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
