import 'dart:convert';

import 'package:bloc_project/core/db_constants.dart';
import 'package:bloc_project/data/models/movie_card_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveUtils {
  static Box? _ourDataBase;
  initDb() async {
    _ourDataBase = Hive.box('movieDB');
  }

  static setString(String key, String value) {
    _ourDataBase?.put(key, value);
  }

  static setMovieId(String key, int value) {
    _ourDataBase?.put(key, value);
  }

  static int? getMovieId(String key) {
    return _ourDataBase?.get(key);
  }

  static String getString(String key) {
    return _ourDataBase?.get(key);
  }

  static void saveMovies(String key, List<MovieCardModel> value) {
    _ourDataBase?.put(key, value);
  }

  static List? getSavedMovies(String key) {
    return _ourDataBase?.get(key);
  }

  static storeSingleMovie(MovieCardModel movie) {
    final Map<String, dynamic> movieJson = movie.toJson();
    final String encodedJson = jsonEncode(movieJson);
    //print("stored data:$encodedJson");
    _ourDataBase?.put(DBConstants.singleMovieKey, encodedJson);
  }

  static fetchSingleMovie() {
    final String fetchedData = _ourDataBase?.get(DBConstants.singleMovieKey);
    final Map<String, dynamic> decodedJson = jsonDecode(fetchedData);
    final MovieCardModel movie = MovieCardModel.fromJson(decodedJson);
    // print("Fetched Data:$decodedJson");
  }

  static storeMovies(List<MovieCardModel> movies) {
    _ourDataBase?.put('Movies', movies);
  }

  static List fetchMovies() {
    final movies = _ourDataBase?.get('Movies') ?? [];
    //  print('Fetch movie collection:${movies.length}');
    final data = List<MovieCardModel>.from(movies);
    final Set<MovieCardModel> tempSet = data.toSet();
    final finalListData = tempSet.toList();
    return finalListData;
  }

//Delete the movie from the local storage with the provided [id]
  static void deleteMovie(int id) {
    //1.fetch local stored movies
    final storedMovies = fetchMovies();
    //2.convert List<dynamic> to List<MovieCardModel>
    final movies = List<MovieCardModel>.from(storedMovies);
    //3.remove the movie element from the list with provided same movie id
    movies.removeWhere((element) => element.id == id);
    //4.store the new movies list after deleting the single movie item
    storeMovies(movies);
  }

  static void deleteAllMovies() {
    _ourDataBase?.delete('Movies');
  }
}
