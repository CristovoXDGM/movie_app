import 'package:movie_app_fteam/app/modules/search/domain/entities/params/search_movies_params.dart';
import 'package:movie_app_fteam/app/modules/search/domain/errors/errors.dart';

import 'package:movie_app_fteam/app/modules/search/infra/datasource/search_movie_datasource.dart';
import 'package:movie_app_fteam/app/modules/search/infra/models/result_search_movie_model.dart';
import 'package:movie_app_fteam/app/modules/shared/constants/api_urls.dart';
import 'package:uno/uno.dart';

class TmdbSearchMoviesByTextDataSource implements SearchDataSource {
  final Uno uno;

  TmdbSearchMoviesByTextDataSource(this.uno);

  String _normalizeSearch(String searchMovieTitle) {
    return searchMovieTitle.replaceAll('from', '+');
  }

  @override
  Future<List<ResultSearchMovieModel>> getSearchMovie(
      SearchMoviesParams params) async {
    final response = await uno.get(
        '${ApiUrls.baseUrl}${ApiUrls.searchMovieBytext}?api_key=${ApiUrls.apiKey}&query=${_normalizeSearch(params.movieTitle)}&page=${params.page} ');

    if (response.status == 200) {
      try {
        final list = (response.data['results'] as List)
            .map((e) => ResultSearchMovieModel.fromMap(e))
            .toList();
        return list;
      } on InvalidMapKey catch (e) {
        throw InvalidMapKey(e.toString());
      }
    } else {
      throw DataSourceSearchResultError();
    }
  }
}
