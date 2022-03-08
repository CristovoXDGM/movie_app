import 'package:movie_app_fteam/app/modules/search/infra/models/result_search_movie_model.dart';

abstract class SearchDataSource {
  Future<List<ResultSearchMovieModel>> getSearchMovie(String? movieTitle);
}
