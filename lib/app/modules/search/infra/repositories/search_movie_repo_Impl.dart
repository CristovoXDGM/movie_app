import 'package:dartz/dartz.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/result_search.dart';
import 'package:movie_app_fteam/app/modules/search/domain/errors/errors.dart';
import 'package:movie_app_fteam/app/modules/search/domain/repositories/search_movie_repository.dart';
import 'package:movie_app_fteam/app/modules/search/infra/datasource/search_movie_datasource.dart';
import 'package:movie_app_fteam/app/modules/search/infra/models/result_search_movie_model.dart';

class SearchRepositoryImpl implements SearchMovieRepository {
  final SearchDataSource dataSource;

  SearchRepositoryImpl(this.dataSource);

  @override
  Future<Either<SearchMoviesException, List<ResultSearchEntity>>> search(
      String? movieTitle) async {
    List<ResultSearchMovieModel>? list;

    try {
      list = await dataSource.getSearchMovie(movieTitle);
    } on DataSourceSearchResultError catch (e) {
      left(e);
    } catch (list) {
      left(DataSourceSearchResultError());
    }

    return list == null ? left(DataSourceSearchResultError()) : right(list);
  }
}
