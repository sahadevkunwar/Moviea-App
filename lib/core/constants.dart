class MovieConstants {
  MovieConstants._internal();
  static String key = 'caebc202bd0a26f84f4e0d986beb15cd';
  static String baseUrl = 'https://api.themoviedb.org/3/movie';
  //tatic String kThemovieDiscoverdbURL = "https://api.themoviedb.org/3/discover/movie";
  // static String searchBaseURL = "https://api.themoviedb.org/3/search/movie";
  // static String searchMovieUrl =
  //     '$searchBaseURL?api_key=$key&language=en-US&page=1&include_adult=false';
  static String searchMovieUrl =
      'https://api.themoviedb.org/3/search/movie?api_key=$key&language=en-US&page=1&include_adult=false&';
  //static String movieDetailUrl = '$baseUrl?api_key=$key&sort_by=popularity.desc&with_genres=$genreId';
  //static String movieDetailUrl = '$baseUrl/$movieID?api_key=$key&language=en-US';
}
