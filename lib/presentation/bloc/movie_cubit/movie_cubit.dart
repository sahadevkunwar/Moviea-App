import 'package:bloc_project/data/data_source/movie_data_source.dart';
import 'package:bloc_project/data/models/movie_card_model.dart';
import 'package:bloc_project/data/repository/movie_repository.dart';
import 'package:bloc_project/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(MovieInitial());
  // final MovieRepository _movieRepository = MovieRepository(MovieDataSource());
  final MovieRepository _movieRepository = getIt<MovieRepository>();

  //calls [_movieRepository] methods passing the [url]
  void getUpcomingMovies({required String apiUrl}) async {
    final movieResult = await _movieRepository.getUpcomingMovies(url: apiUrl);
    // print('MovieResult:$movieResult');
    emit(MovieFetched(movieResult));
  }

  // void getMovieDetails({required int movieId}) async {
  //   final movieDetails =
  //       await _movieRepository.getMovieDetails(movieId: movieId);
  //   if (movieDetails != null) {
  //     emit(MovieDetailsFetched(movieDetails));
  //   }
  // }
}
