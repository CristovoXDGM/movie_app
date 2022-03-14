import 'package:dartz/dartz.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/movie_category.dart';
import 'package:movie_app_fteam/app/modules/search/domain/errors/errors.dart';
import 'package:movie_app_fteam/app/modules/search/domain/repositories/get_movie_category_repository.dart';

// Todo: change the use case name
abstract class GetMovieCategoriesUseCase {
  Future<Either<SearchMoviesException, List<MovieCategoriesEntity>>> call(
      String selectedMovieCategory);
}

class SelectMovieCategoryImpl implements GetMovieCategoriesUseCase {
  final GetMovieCategoryRepository selectMovieCategoryRepository;

  SelectMovieCategoryImpl(this.selectMovieCategoryRepository);

  @override
  Future<Either<SearchMoviesException, List<MovieCategoriesEntity>>> call(
      String selectedMovieCategory) async {
    if (selectedMovieCategory.isEmpty) {
      return Left(InvalidMovieCategory());
    }

    return selectMovieCategoryRepository.selectCategory(selectedMovieCategory);
  }
}
