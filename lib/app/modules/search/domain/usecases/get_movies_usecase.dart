import 'package:dartz/dartz.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/result_search.dart';
import 'package:movie_app_fteam/app/modules/search/domain/errors/errors.dart';
import 'package:movie_app_fteam/app/modules/search/domain/repositories/get_movies_repository.dart';

abstract class GetMoviesUseCase {
  Future<Either<SearchMoviesException, List<ResultSearchEntity>>> call();
}

class GetMoviesUseCaseImpl implements GetMoviesUseCase {
  final GetMoviesRepository getMoviesRepository;

  GetMoviesUseCaseImpl(this.getMoviesRepository);

  @override
  Future<Either<SearchMoviesException, List<ResultSearchEntity>>> call() async {
    return getMoviesRepository.getMovies();
  }
}
