import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'movie_search_state.dart';

class MovieSearchCubit extends Cubit<MovieSearchState> {
  MovieSearchCubit() : super(MovieSearchInitial());
}
