abstract class SearchMovieEvent {}

class StartSearchMoviesEvent implements SearchMovieEvent {
  final String movieTitle;
  final int page;
  StartSearchMoviesEvent({this.movieTitle = '', this.page = 1});
}
