import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app_fteam/app/modules/search/domain/errors/errors.dart';
import 'package:movie_app_fteam/app/modules/search/external/datasource/tmdb_get_movies_categories.dart';
import 'package:movie_app_fteam/app/modules/search/infra/datasource/get_movie_categories_datasource.dart';
import 'package:movie_app_fteam/app/modules/shared/utils/tmdv_categories_response.dart';
import 'package:uno/uno.dart';

class UnoMock extends Mock implements Uno {}

class RequestOptionsMock extends Mock implements Request {}

void main() {
  late Uno uno;
  late GetMovieCategoryDataSource dataSource;

  setUpAll(() {
    uno = UnoMock();
    dataSource = TmdbGetMovieCategoriesDataSource(uno);
  });

  test('Should return a list of GetMovieCategoryModel ', () {
    when(() => uno.get(any())).thenAnswer((invocation) async => Response(
        headers: {'Content-Type': 'application/json'},
        request: RequestOptionsMock(),
        status: 200,
        data: jsonDecode(tmdbCategoriesResponse)));

    final future = dataSource.getMovieCategories();

    expect(future, completes);
  });
  test('Should return a  CategoriesUnavailable error', () {
    when(() => uno.get(any())).thenAnswer((invocation) async => Response(
        headers: {'Content-Type': 'application/json'},
        request: RequestOptionsMock(),
        status: 401,
        data: null));

    final future = dataSource.getMovieCategories();

    expect(future, throwsA(isA<CategoriesUnavailable>()));
  });
}
