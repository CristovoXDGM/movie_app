import 'package:dartz/dartz.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/params/search_movies_params.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/result_search.dart';
import 'package:movie_app_fteam/app/modules/search/domain/errors/errors.dart';

abstract class SearchMovieRepository {
  Future<Either<SearchMoviesException, List<ResultSearchEntity>>> search(
      SearchMoviesParams params);
}
