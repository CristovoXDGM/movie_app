import 'package:dartz/dartz.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/movie_category.dart';
import 'package:movie_app_fteam/app/modules/search/domain/errors/errors.dart';

abstract class GetMovieCategoryRepository {
  Future<Either<SearchMoviesException, List<MovieCategoriesEntity>>>
      selectCategory(String selectedMovieCategory);
}
