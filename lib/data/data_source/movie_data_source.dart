import 'package:bloc_project/core/constants.dart';
import 'package:bloc_project/data/models/movie_card_model.dart';
import 'package:bloc_project/data/models/movie_details_model.dart';
import 'package:bloc_project/data/models/searched_movie_model.dart';
import 'package:bloc_project/main.dart';
import 'package:dio/dio.dart';

//Data source where all the api calls are handled
class MovieDataSource {
  //initializing dio client when the object of MovieDataSource is created
  //   MovieDataSource(this._dioClient);
  MovieDataSource() : _dioClient = getIt<Dio>();
  late final Dio _dioClient;

  Future<List<MovieCardModel>> fetchUpcomingMovies(
      {required String upcomingMoviesUrl}) async {
    Map<String, dynamic> json = {};
    List<MovieCardModel> movieCardList = [];
    final Response<Map<String, dynamic>> jsonResponse =
        await _dioClient.get(upcomingMoviesUrl);
    if (jsonResponse.data != null) {
      json = jsonResponse.data!;
    }
    for (var element in json['results']) {
      final MovieCardModel movieCard = MovieCardModel.fromJson(element);
      movieCardList.add(movieCard);
    }

    return movieCardList;
  }

  Future<MovieDetailsModel?> fetchMovieDetails({required int movieId}) async {
    MovieDetailsModel? movieDetailsModel;
    final Response<
        Map<String,
            dynamic>> movieDetailResponse = await _dioClient.get(
        '${MovieConstants.baseUrl}/$movieId?api_key=${MovieConstants.key}&language=en-US');
    final Map<String, dynamic>? movieJson = movieDetailResponse.data;
    if (movieJson != null) {
      movieDetailsModel = MovieDetailsModel.fromJson(movieJson);
    }
    return movieDetailsModel;
  }

  Future<SearchedMovieModel?> searchMovie({required String userQuery}) async {
    SearchedMovieModel? searchedMovieModel;
    final String movieSearchApiPath =
        '${MovieConstants.searchMovieUrl}query=$userQuery';
    final Response<Map<String, dynamic>> movieDetailResponse =
        await _dioClient.get(movieSearchApiPath);
    final Map<String, dynamic>? movieJson = movieDetailResponse.data;
    if (movieJson != null) {
      searchedMovieModel = SearchedMovieModel.fromJson(movieJson);
    }
    return searchedMovieModel;
    //print('api data ${searchedMovieModel}');
  }
}
