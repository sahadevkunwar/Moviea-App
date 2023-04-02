//calls the appropriate data source and its related method calls

import 'package:bloc_project/data/data_source/movie_data_source.dart';
import 'package:bloc_project/data/models/movie_card_model.dart';
import 'package:bloc_project/data/models/movie_details_model.dart';
import 'package:bloc_project/data/models/searched_movie_model.dart';

class MovieRepository {
  MovieRepository(this._movieDataSource);
  late final MovieDataSource _movieDataSource;

//calls [_movieDataSource] methods passing the [url]
  Future<List<MovieCardModel>> getUpcomingMovies({required String url}) async {
    return await _movieDataSource.fetchUpcomingMovies(upcomingMoviesUrl: url);
  }

  Future<MovieDetailsModel?> getMovieDetails({required int movieId}) async {
    return await _movieDataSource.fetchMovieDetails(movieId: movieId);
  }

  Future<SearchedMovieModel?> searchMovie(
      {required String querFromCubit}) async {
    return await _movieDataSource.searchMovie(userQuery: querFromCubit);
  }
}
