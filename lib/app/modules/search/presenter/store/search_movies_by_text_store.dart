import 'package:flutter_triple/flutter_triple.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/params/search_movies_params.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/result_search.dart';
import 'package:movie_app_fteam/app/modules/search/domain/errors/errors.dart';
import 'package:movie_app_fteam/app/modules/search/domain/usecases/search_movie_by_text_usecase.dart';

class SearchMoviesByTextStore
    extends StreamStore<SearchMoviesException, List<ResultSearchEntity>> {
  final SearchMovieByTextUseCase useCase;

  SearchMoviesByTextStore(this.useCase) : super([]);

  Future<void> getMoviesByText(String movieTitle, [int page = 1]) async {
    List<ResultSearchEntity> currentMoviesList = [];

    setLoading(true);

    final results =
        await useCase(SearchMoviesParams(movieTitle: movieTitle, page: page));

    results.fold(setError, (r) {
      update(currentMoviesList + r);
      page++;
    });
    setLoading(false);
  }
}
