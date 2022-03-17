import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/params/search_movies_params.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/result_search.dart';
import 'package:movie_app_fteam/app/modules/search/domain/errors/errors.dart';
import 'package:movie_app_fteam/app/modules/search/domain/repositories/search_movie_repository.dart';
import 'package:movie_app_fteam/app/modules/search/infra/datasource/search_movie_datasource.dart';
import 'package:movie_app_fteam/app/modules/search/infra/models/result_search_movie_model.dart';
import 'package:movie_app_fteam/app/modules/search/infra/repositories/search_movie_repo_Impl.dart';

class SearchRepositorDatasourceMock extends Mock implements SearchDataSource {}

void main() {
  late SearchRepositorDatasourceMock datasource;

  late SearchMovieRepository repository;

  setUpAll(() {
    datasource = SearchRepositorDatasourceMock();
    repository = SearchRepositoryImpl(datasource);
    registerFallbackValue(SearchMoviesParams());
  });

  test('Should return a list of ResultSearchEntity', () async {
    when(() => datasource.getSearchMovie(any()))
        .thenAnswer((invocation) async => <ResultSearchMovieModel>[]);

    final result =
        await repository.search(SearchMoviesParams(movieTitle: 'batman'));

    expect(result.fold(id, id), isA<List<ResultSearchEntity>>());
  });
  test(
      'Should return DataSourceSearchResultNull or DataSourceSearchResultError',
      () async {
    when(() => datasource.getSearchMovie(any()))
        .thenThrow(DataSourceSearchResultError());

    final result =
        await repository.search(SearchMoviesParams(movieTitle: 'batman'));

    expect(result.fold(id, id), isA<DataSourceSearchResultError>());
  });
}
