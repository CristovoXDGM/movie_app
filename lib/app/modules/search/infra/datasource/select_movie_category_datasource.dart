import 'package:movie_app_fteam/app/modules/search/infra/models/get_movie_category_model.dart';

abstract class GetMovieCategoryDataSource {
  Future<List<GetMovieCategoryModel>> getMoviesCategories(String movieCategory);
}
