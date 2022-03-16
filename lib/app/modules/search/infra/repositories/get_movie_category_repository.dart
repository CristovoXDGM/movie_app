import 'package:movie_app_fteam/app/modules/search/domain/errors/errors.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/movie_category.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_app_fteam/app/modules/search/domain/repositories/get_movie_category_repository.dart';
import 'package:movie_app_fteam/app/modules/search/infra/datasource/get_movie_categories_datasource.dart';
import 'package:movie_app_fteam/app/modules/search/infra/models/get_movie_category_model.dart';

class GetMovieCategoryRepositoryImpl implements GetMovieCategoriesRepository {
  final GetMovieCategoryDataSource dataSource;

  GetMovieCategoryRepositoryImpl(this.dataSource);

  @override
  Future<Either<CategoriesUnavailable, List<MovieCategoriesEntity>>>
      getCategories() async {
    try {
      final List<GetMovieCategoryModel> categoriesList =
          await dataSource.getMovieCategories();
      return right(categoriesList);
    } on CategoriesUnavailable {
      return left(CategoriesUnavailable());
    }
  }
}
