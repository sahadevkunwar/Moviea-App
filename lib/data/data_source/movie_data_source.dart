import 'package:bloc_project/core/base/dio_remote.dart';
import 'package:bloc_project/core/constants.dart';
import 'package:bloc_project/core/exception/api_exception.dart';
import 'package:bloc_project/data/models/movie_card_model.dart';
import 'package:bloc_project/data/models/movie_details_model.dart';
import 'package:bloc_project/data/models/searched_movie_model.dart';
import 'package:bloc_project/main.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

//Data source where all the api calls are handled
class MovieDataSource extends BaseRemoteSource {
  //initializing dio client when the object of MovieDataSource is created
  //   MovieDataSource(this._dioClient);
  MovieDataSource() : _dioClient = getIt<Dio>();
  late final Dio _dioClient;

  Future<Either<ApiException, List<MovieCardModel>>> fetchUpcomingMovies(
      {required String upcomingMoviesUrl}) async {
    //  Map<String, dynamic> json = {};
    List<MovieCardModel> movieCardList = [];

    return networkHandler(request: (Dio dio) {
      return dio.get(upcomingMoviesUrl);
    }, onResponse: (Map<String, dynamic> data) {
      for (var element in data['results']) {
        final MovieCardModel movieCard = MovieCardModel.fromJson(element);
        movieCardList.add(movieCard);
      }
      return right(movieCardList);
    });
    // final eitherData = await HandleNetworkCall().getData(upcomingMoviesUrl);
    // return eitherData.fold(
    //   (serverError) => left(serverError),
    //   (json) {
    //     for (var element in json['results']) {
    //       final MovieCardModel movieCard = MovieCardModel.fromJson(element);
    //       movieCardList.add(movieCard);
    //     }
    //     return right(movieCardList);
    //   },
    // );

    // try {
    //   final Response<Map<String, dynamic>> jsonResponse =
    //       await _dioClient.get(upcomingMoviesUrl);
    //   //print('STATUS CODE:${jsonResponse.statusCode}');
    //   if (jsonResponse.statusCode == 200) {
    //     if (jsonResponse.data != null) {
    //       json = jsonResponse.data!;
    //     }
    //
    //     return right(movieCardList);
    //   }
    // } on DioError catch (error) {
    //   return left('Unable to process your request');
    // }
    // return left('Unable to process your request');
  }

  Future<MovieDetailsModel?> fetchMovieDetails({required int movieId}) async {
    MovieDetailsModel? movieDetailsModel;
    print('At datasource');

    return networkHandler(request: (dio) {
      return dio.get(
          '${MovieConstants.baseUrl}/$movieId?api_key=${MovieConstants.key}&language=en-US');
    }, onResponse: (responseJson) {
      final movieDetailsModel = MovieDetailsModel.fromJson(responseJson);
      return movieDetailsModel;
    });
  }

  // final Response<
  //     Map<String,
  //         dynamic>> movieDetailResponse = await _dioClient.get(
  //     '${MovieConstants.baseUrl}/$movieId?api_key=${MovieConstants.key}&language=en-US');
  // final Map<String, dynamic>? movieJson = movieDetailResponse.data;
  // if (movieJson != null) {
  //   movieDetailsModel = MovieDetailsModel.fromJson(movieJson);
  // }
  // return movieDetailsModel;

  Future<Either<String?, SearchedMovieModel?>> searchMovie(
      {required String userQuery}) async {
    SearchedMovieModel? searchedMovieModel;
    final String movieSearchApiPath =
        '${MovieConstants.searchMovieUrl}query=$userQuery';
    return networkHandler(
        request: (dio) => dio.get(movieSearchApiPath),
        onResponse: (movieDetailResponse) {
          searchedMovieModel = SearchedMovieModel.fromJson(movieDetailResponse);
          return right(searchedMovieModel);
        });
    // final Response<Map<String, dynamic>> movieDetailResponse =
    //     await _dioClient.get(movieSearchApiPath);
    // final Map<String, dynamic>? movieJson = movieDetailResponse.data;
    // if (movieJson != null) {
    //   searchedMovieModel = SearchedMovieModel.fromJson(movieJson);
    // }
    // return searchedMovieModel;
    //print('api data ${searchedMovieModel}');
  }
}

enum HttpType { get, post, delete, patch }
