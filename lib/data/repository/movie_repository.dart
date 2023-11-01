//calls the appropriate data source and its related method calls

import 'package:bloc_project/core/base/base_repository.dart';
import 'package:bloc_project/core/exception/api_exception.dart';
import 'package:bloc_project/data/data_source/movie_data_source.dart';
import 'package:bloc_project/data/models/movie_card_model.dart';
import 'package:bloc_project/data/models/movie_details_model.dart';
import 'package:bloc_project/data/models/searched_movie_model.dart';
// ignore: depend_on_referenced_packages
import 'package:dartz/dartz.dart';

class MovieRepository extends BaseRepository {
  MovieRepository(this._movieDataSource);
  late final MovieDataSource _movieDataSource;

//calls [_movieDataSource] methods passing the [url]
  Future<Either<ApiException, List<MovieCardModel>>> getUpcomingMovies(
      {required String url}) async {
    return await _movieDataSource.fetchUpcomingMovies(upcomingMoviesUrl: url);
  }

  Future<Either<String?, MovieDetailsModel?>> getMovieDetails(
      {required int movieId}) async {
    return handleNetworkCall(
        call: _movieDataSource.fetchMovieDetails(movieId: movieId),
        onSuccess: (data) => data);

    // try {
    //   final movieDetailModel =
    //       await _movieDataSource.fetchMovieDetails(movieId: movieId);
    //   return right(movieDetailModel as MovieDetailsModel?);
    // } on String catch (e) {
    //   return left(e);
    // } catch (e) {
    //   return left(e.toString());
    // }
  }

  Future<Either<String?, SearchedMovieModel?>> searchMovie(
      {required String queryFromCubit}) async {
    return await _movieDataSource.searchMovie(userQuery: queryFromCubit);
  }
}
