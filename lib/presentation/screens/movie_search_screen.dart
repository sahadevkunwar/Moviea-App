import 'package:auto_route/auto_route.dart';
import 'package:bloc_project/data/models/searched_movie_model.dart';
import 'package:bloc_project/main.dart';
import 'package:bloc_project/presentation/bloc/movie_search_cubit/movie_search_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class MovieSearchScreen extends StatefulWidget {
  const MovieSearchScreen({super.key});

  @override
  State<MovieSearchScreen> createState() => _MovieSearchScreenState();
}

class _MovieSearchScreenState extends State<MovieSearchScreen> {
  late TextEditingController _searchQueryController;
  late MovieSearchCubit _movieSearchCubit;
  @override
  void initState() {
    super.initState();
    _movieSearchCubit = getIt<MovieSearchCubit>();
    _searchQueryController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: TextFormField(
          textInputAction: TextInputAction.search,
          controller: _searchQueryController,
          decoration: const InputDecoration(
            hintText: 'Search Movie',
          ),
          onFieldSubmitted: (inputFromUser) {
            _movieSearchCubit.searchMovie(queryFromUI: inputFromUser);
          },
        ),
      ),
      body: Container(
        color: Colors.black87,
        child: Column(
          children: [
            BlocBuilder<MovieSearchCubit, MovieSearchState>(
              bloc: _movieSearchCubit,
              builder: (context, state) {
                if (state is MovieFetching) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SearchedMovieFetched) {
                  final SearchedMovieModel searchedMovie =
                      state.searchedMovieModel;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          mainAxisExtent: 300,
                        ),
                        itemCount: searchedMovie.results.length,
                        itemBuilder: (context, index) {
                          final singleMovie = searchedMovie.results[index];
                          return Card(
                            color: Colors.grey,
                            child: Column(
                              children: [
                                CachedNetworkImage(
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/w300${singleMovie.posterPath}',
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                  errorWidget: (context, url, error) =>
                                      const Center(
                                          child: Text('No image available')),
                                ),
                                Text(
                                  singleMovie.originalTitle,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                Flexible(
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(
                                        singleMovie.overview,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else if (state is SearchedError) {
                  return Center(child: Text(state.errorMessage));
                }
                return const Center(
                    child: Text('You have not searched any movies yet'));
              },
            )
          ],
        ),
      ),
    );
  }
}
