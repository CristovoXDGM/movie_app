import 'package:dartz/dartz.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/movie_category.dart';
import 'package:movie_app_fteam/app/modules/search/domain/errors/errors.dart';
import 'package:movie_app_fteam/app/modules/search/domain/repositories/get_movie_category_repository.dart';

abstract class GetMovieCategoriesUseCase {
  Future<Either<CategoriesUnavailable, List<MovieCategoriesEntity>>> call();
}

class GetMovieCategoriesImpl implements GetMovieCategoriesUseCase {
  final GetMovieCategoriesRepository getMovieCategoriesRepository;

  GetMovieCategoriesImpl(this.getMovieCategoriesRepository);

  @override
  Future<Either<CategoriesUnavailable, List<MovieCategoriesEntity>>>
      call() async {
    return getMovieCategoriesRepository.getCategories();
  }
}
