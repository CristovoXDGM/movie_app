import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/params/search_movies_params.dart';
import 'package:movie_app_fteam/app/modules/search/domain/errors/errors.dart';
import 'package:movie_app_fteam/app/modules/search/external/datasource/tmdb_search_movies_by_text_datasource.dart';
import 'package:movie_app_fteam/app/modules/search/infra/datasource/search_movie_datasource.dart';

import 'package:uno/uno.dart';

import '../../utils/tmdb_search_response.dart';

class UnoMock extends Mock implements Uno {}

class RequestOptionsMock extends Mock implements Request {}

void main() {
  late Uno uno;
  late SearchDataSource dataSource;

  setUpAll(() {
    uno = UnoMock();
    dataSource = TmdbSearchMoviesByTextDataSource(uno);
    registerFallbackValue(SearchMoviesParams());
  });

  test('Should return a list of ResultSearchMovieModel', () {
    when(() => uno.get(any())).thenAnswer(
      (invocation) async => Response(
          headers: {'Content-Type': 'application/json'},
          data: jsonDecode(tmdbResponse),
          request: RequestOptionsMock(),
          status: 200),
    );

    final future =
        dataSource.getSearchMovie(SearchMoviesParams(movieTitle: 'batman'));

    expect(future, completes);
  });

  test('Should return a DataSourceSearchResultError', () {
    when(() => uno.get(any())).thenAnswer((invocation) async => Response(
        headers: {'Content-Type': 'application/json'},
        request: RequestOptionsMock(),
        data: null,
        status: 401));

    final future =
        dataSource.getSearchMovie(SearchMoviesParams(movieTitle: 'batman'));

    expect(future, throwsA(isA<DataSourceSearchResultError>()));
  });
}
