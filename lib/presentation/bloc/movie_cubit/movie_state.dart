part of 'movie_cubit.dart';

abstract class MovieState extends Equatable {
  MovieState();
}

class Equatable {}

class MovieInitial extends MovieState {
  List<Object> get props => [];
}
class MovieFetching extends MovieState {
  List<Object> get props => [];
}

class MovieFetched extends MovieState {
  MovieFetched(this.moviesCard);
  final List<MovieCardModel> moviesCard;
  List<Object> get props => [moviesCard];
}

// class MovieDetailsFetched extends MovieState {
//   MovieDetailsFetched(this.movieDetailsModel);
//   MovieDetailsModel movieDetailsModel;
//   List<Object?> get props => [movieDetailsModel];
// }
