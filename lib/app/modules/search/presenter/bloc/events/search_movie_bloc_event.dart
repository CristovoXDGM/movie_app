import 'package:movie_app_fteam/app/modules/search/domain/entities/result_search.dart';

abstract class SearchMovieEvent {}

class LoadSearchMoviesEvent implements SearchMovieEvent {
  final List<ResultSearchEntity> results;

  LoadSearchMoviesEvent(this.results);
}

class StartSearchMoviesEvent implements SearchMovieEvent {
  final String movieTitle;

  StartSearchMoviesEvent({this.movieTitle = ""});
}
