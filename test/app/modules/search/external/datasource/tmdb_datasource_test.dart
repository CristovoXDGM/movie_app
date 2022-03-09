import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app_fteam/app/modules/search/domain/errors/errors.dart';
import 'package:movie_app_fteam/app/modules/search/external/datasource/tmdb_datasource.dart';
import 'package:movie_app_fteam/app/modules/search/infra/datasource/search_movie_datasource.dart';
import 'package:movie_app_fteam/app/modules/search/utils/tmdb_search_response.dart';

class DioMock extends Mock implements Dio {}

class RequestOptionsMock extends Mock implements RequestOptions {}

void main() {
  final dio = DioMock();
  final SearchDataSource dataSource = TmdbDataSource(dio);

  test("Should return a list from ResultSearchMovieModel", () {
    when(() => dio.get(any())).thenAnswer((invocation) async => Response(
        requestOptions: RequestOptionsMock(),
        data: jsonDecode(tmdbResponse),
        statusCode: 200));

    final future = dataSource.getSearchMovie("spider man");

    expect(future, completes);
  });

  test("Should return a DataSourceSearchResultError", () {
    when(() => dio.get(any())).thenAnswer((invocation) async => Response(
        requestOptions: RequestOptionsMock(), data: null, statusCode: 401));

    final future = dataSource.getSearchMovie("spider man");

    expect(future, throwsA(isA<DataSourceSearchResultError>()));
  });
}
