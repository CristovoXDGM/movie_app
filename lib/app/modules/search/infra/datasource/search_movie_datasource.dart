import 'package:movie_app_fteam/app/modules/search/domain/entities/params/search_movies_params.dart';
import 'package:movie_app_fteam/app/modules/search/infra/models/result_search_movie_model.dart';

abstract class SearchDataSource {
  Future<List<ResultSearchMovieModel>> getSearchMovie(
      SearchMoviesParams params);
}
