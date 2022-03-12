import 'package:movie_app_fteam/app/modules/search/domain/errors/errors.dart';
import 'package:movie_app_fteam/app/modules/search/infra/datasource/search_movie_datasource.dart';
import 'package:movie_app_fteam/app/modules/search/infra/models/result_search_movie_model.dart';
import 'package:uno/uno.dart';

class TmdbDataSource implements SearchDataSource {
  final Uno uno;

  TmdbDataSource(this.uno);

  String _normalizeSearch(String searchMovieTitle) {
    return searchMovieTitle.replaceAll("from", "+");
  }

  @override
  Future<List<ResultSearchMovieModel>> getSearchMovie(String movieTitle) async {
    //Add base url to uno client http

    final response = await uno.get(
        "https://api.themoviedb.org/3/search/movie?api_key=fa75ca339a4b269c5f893e3aa248220f&query=${_normalizeSearch(movieTitle)}");

    if (response.status == 200) {
      // Create a trycatch to catch the Mapper error
      final list = (response.data['results'] as List)
          .map((e) => ResultSearchMovieModel.fromMap(e))
          .toList();
      return list;
    } else {
      throw DataSourceSearchResultError();
    }
  }
}
