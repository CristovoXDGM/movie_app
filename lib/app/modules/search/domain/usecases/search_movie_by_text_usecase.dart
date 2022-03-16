import 'package:dartz/dartz.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/result_search.dart';
import 'package:movie_app_fteam/app/modules/search/domain/errors/errors.dart';

import 'package:movie_app_fteam/app/modules/search/domain/repositories/search_movie_repository.dart';

abstract class SearchMovieByTextUseCase {
  Future<Either<SearchMoviesException, List<ResultSearchEntity>>> call(
    String movieTitle,
  );
}

class SearchMovieByTextImpl implements SearchMovieByTextUseCase {
  final SearchMovieRepository searchMovieRepository;

  SearchMovieByTextImpl(
    this.searchMovieRepository,
  );

  @override
  Future<Either<SearchMoviesException, List<ResultSearchEntity>>> call(
    String movieTitle,
  ) async {
    if (movieTitle.isEmpty) {
      return Left(InvalidMovieNameError());
    }

    return searchMovieRepository.search(movieTitle);
  }
}
