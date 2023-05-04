import 'package:bloc/bloc.dart';
import 'package:bloc_project/core/base/base_bloc.dart';
import 'package:bloc_project/data/models/movie_details_model.dart';
import 'package:bloc_project/data/repository/movie_repository.dart';

import '../../../main.dart';
import '../movie_cubit/movie_cubit.dart';

part 'moviedetail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> with BaseBlocMixin {
  MovieDetailCubit() : super(MovieDetailsInitial());
  // final MovieRepository movieRepository = MovieRepository(MovieDataSource());
  final MovieRepository _movieRepository = getIt<MovieRepository>();

  void getMovieDetails({required int movieId}) async {
    print('At cubit');
    emit(MovieDetailsInitial());
    handleBlocData(
        response: await _movieRepository.getMovieDetails(movieId: movieId),
        onData: (movieDetails) {
          if (movieDetails != null) {
            emit(MovieDetailsFetched(movieDetails));
          }
        },
        onFailure: (String? error) {
          emit(MovieDetailError(error!));
        });
    // final response = await _movieRepository.getMovieDetails(movieId: movieId);
    // response.fold((error) => null, (movieDetails) {
    //   if (movieDetails != null) {
    //     emit(MovieDetailsFetched(movieDetails));
    //   }
    // });
  }
}
