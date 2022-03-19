import 'package:movie_app_fteam/app/modules/search/domain/errors/errors.dart';
import 'package:movie_app_fteam/app/modules/search/infra/datasource/get_movies_datasource.dart';
import 'package:movie_app_fteam/app/modules/search/infra/models/result_search_movie_model.dart';
import 'package:uno/uno.dart';

class TmdbGetMoviesDataSource implements GetMoviesDatasource {
  final Uno uno;

  TmdbGetMoviesDataSource(this.uno);

  @override
  Future<List<ResultSearchMovieModel>> getMovies() async {
    //Todo: add the base url with the paramenters

    final response = await uno.get('url');

    if (response.status == 200) {
      //Todo: Add key name to the list mapper
      final moviesList = (response.data[''] as List)
          .map((e) => ResultSearchMovieModel.fromMap(e))
          .toList();

      return moviesList;
    } else {
      throw DataSourceSearchResultError();
    }
  }
}
