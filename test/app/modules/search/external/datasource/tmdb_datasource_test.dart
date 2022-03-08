import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app_fteam/app/modules/search/external/datasource/tmdb_datasource.dart';
import 'package:movie_app_fteam/app/modules/search/infra/datasource/search_movie_datasource.dart';

class DioMock extends Mock implements Dio {}

void main() {
  final dio = DioMock();
  final SearchDataSource dataSource = TmdbDataSource(dio);

  test("Should return a lis from ResultSearchMovieModel", () {
    // when(()=>dio.get(any())).thenAnswer((invocation) => null)
  });
}
