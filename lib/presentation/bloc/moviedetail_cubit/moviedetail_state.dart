part of 'moviedetail_cubit.dart';

abstract class MovieDetailState extends Equatable {
  MovieDetailState();
}

class MovieDetailsInitial extends MovieDetailState {
  List<Object> get props => [];
}

class MovieDetailError extends MovieDetailState {
  final String error;
  MovieDetailError(this.error);
  List<Object> get props => [error];
}

class MovieDetailsFetched extends MovieDetailState {
  MovieDetailsFetched(this.movieDetailsModel);
  MovieDetailsModel movieDetailsModel;

  List<Object> get props => [movieDetailsModel];
}
