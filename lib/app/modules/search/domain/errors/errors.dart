abstract class SearchMoviesException implements Exception {}

class InvalidMovieNameError implements SearchMoviesException {}

class InvalidMovieCategory implements SearchMoviesException {}

class DataSourceSearchResultError implements SearchMoviesException {
  final String? message;

  DataSourceSearchResultError({this.message});
}
