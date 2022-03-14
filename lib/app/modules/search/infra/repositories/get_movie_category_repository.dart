import 'package:movie_app_fteam/app/modules/search/domain/errors/errors.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/movie_category.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_app_fteam/app/modules/search/domain/repositories/get_movie_category_repository.dart';
import 'package:movie_app_fteam/app/modules/search/infra/datasource/select_movie_category_datasource.dart';
import 'package:movie_app_fteam/app/modules/search/infra/models/get_movie_category_model.dart';

class GetMovieCategoryRepositoryImpl implements GetMovieCategoryRepository {
  final GetMovieCategoryDataSource dataSource;

  GetMovieCategoryRepositoryImpl(this.dataSource);

  @override
  Future<Either<SearchMoviesException, List<MovieCategoriesEntity>>>
      selectCategory(String selectedMovieCategory) async {
    try {
      final List<GetMovieCategoryModel> categoriesList =
          await dataSource.getMoviesCategories(selectedMovieCategory);
      return right(categoriesList);
    } on InvalidMovieCategory catch (e) {
      return left(e);
    }
  }
}
