abstract class SearchMovieEvent {}

class StartSearchMoviesEvent implements SearchMovieEvent {
  final String movieTitle;

  StartSearchMoviesEvent({this.movieTitle = ''});
}
