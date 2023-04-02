import 'package:bloc/bloc.dart';
import 'package:bloc_project/data/models/searched_movie_model.dart';
import 'package:bloc_project/data/repository/movie_repository.dart';
import 'package:bloc_project/main.dart';
import 'package:equatable/equatable.dart';

part 'movie_search_state.dart';

class MovieSearchCubit extends Cubit<MovieSearchState> {
  MovieSearchCubit()
      : _movieRepository = getIt<MovieRepository>(),
        super(MovieSearchInitial());
  late final MovieRepository _movieRepository;

  void searchMovie({required String queryFromUI}) async {
    emit(MovieFetching());
    final SearchedMovieModel? movieModel =
        await _movieRepository.searchMovie(querFromCubit: queryFromUI);
    _checkResultResponse(movieModel);
  }

  void _checkResultResponse(SearchedMovieModel? movieModel) {
    if (movieModel != null && movieModel.results.isNotEmpty) {
      emit(SearchedMovieFetched(searchedMovieModel: movieModel));
    } else {
      emit(const SearchedError(errorMessage: 'No result found'));
    }
  }
}
