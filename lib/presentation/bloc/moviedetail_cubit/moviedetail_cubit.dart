import 'package:bloc/bloc.dart';
import 'package:bloc_project/data/data_source/movie_data_source.dart';
import 'package:bloc_project/data/models/movie_details_model.dart';
import 'package:bloc_project/data/repository/movie_repository.dart';

import '../movie_cubit/movie_cubit.dart';

part 'moviedetail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit() : super(MovieDetailsInitial());
  final MovieRepository movieRepository = MovieRepository(MovieDataSource());

  void getMovieDetails({required int movieId}) async {
    final movieDetails =
        await movieRepository.getMovieDetails(movieId: movieId);
    if (movieDetails != null) {
      emit(MovieDetailsFetched(movieDetails));
    }
  }
}
