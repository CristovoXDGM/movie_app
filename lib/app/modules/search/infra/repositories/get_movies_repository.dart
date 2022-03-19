import 'package:movie_app_fteam/app/modules/search/domain/errors/errors.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/result_search.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_app_fteam/app/modules/search/domain/repositories/get_movies_repository.dart';
import 'package:movie_app_fteam/app/modules/search/infra/datasource/get_movies_datasource.dart';
import 'package:movie_app_fteam/app/modules/search/infra/models/result_search_movie_model.dart';

class GetMoviesRepositoryImpl implements GetMoviesRepository {
  final GetMoviesDatasource getMoviesDatasource;

  GetMoviesRepositoryImpl(this.getMoviesDatasource);

  @override
  Future<Either<SearchMoviesException, List<ResultSearchMovieModel>>>
      getMovies() async {
    try {
      final List<ResultSearchMovieModel> moviesList =
          await getMoviesDatasource.getMovies();

      return right(moviesList);
    } on DataSourceSearchResultError {
      return left(
        DataSourceSearchResultError(),
      );
    }
  }
}
