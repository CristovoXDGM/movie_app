abstract class SearchMoviesException implements Exception {}

class InvalidMovieNameError implements SearchMoviesException {}

class CategoriesUnavailable implements SearchMoviesException {}

class InvalidMapKey implements SearchMoviesException {
  final String? message;

  InvalidMapKey(this.message);
}

class InvalidMovieCategory implements SearchMoviesException {}

class DataSourceSearchResultError implements SearchMoviesException {
  final String? message;

  DataSourceSearchResultError({this.message});
}
