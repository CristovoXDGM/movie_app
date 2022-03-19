import 'package:movie_app_fteam/app/modules/search/domain/errors/errors.dart';
import 'package:movie_app_fteam/app/modules/search/infra/datasource/get_movie_categories_datasource.dart';
import 'package:movie_app_fteam/app/modules/search/infra/models/get_movie_category_model.dart';
import 'package:movie_app_fteam/app/modules/shared/constants/api_urls.dart';
import 'package:uno/uno.dart';

class TmdbGetMovieCategoriesDataSource implements GetMovieCategoryDataSource {
  final Uno uno;

  TmdbGetMovieCategoriesDataSource(this.uno);

  @override
  Future<List<GetMovieCategoryModel>> getMovieCategories() async {
    final response = await uno.get(
        '${ApiUrls.baseUrl}${ApiUrls.getMovieCategories}?api_key=${ApiUrls.apiKey}');

    if (response.status == 200) {
      final movieCategoriesList = (response.data['genres'] as List)
          .map((e) => GetMovieCategoryModel.fromMap(e))
          .toList();

      return movieCategoriesList;
    } else {
      throw CategoriesUnavailable();
    }
  }
}
