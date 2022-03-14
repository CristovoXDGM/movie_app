import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/movie_category.dart';
import 'package:movie_app_fteam/app/modules/search/domain/errors/errors.dart';
import 'package:movie_app_fteam/app/modules/search/domain/repositories/get_movie_category_repository.dart';
import 'package:movie_app_fteam/app/modules/search/infra/datasource/select_movie_category_datasource.dart';
import 'package:movie_app_fteam/app/modules/search/infra/models/get_movie_category_model.dart';
import 'package:movie_app_fteam/app/modules/search/infra/repositories/get_movie_category_repository.dart';

class GetMovieCategoryDatasourceMock extends Mock
    implements GetMovieCategoryDataSource {}

void main() {
  late GetMovieCategoryDataSource dataSource;
  late GetMovieCategoryRepository repository;

  setUpAll(() {
    dataSource = GetMovieCategoryDatasourceMock();
    repository = GetMovieCategoryRepositoryImpl(dataSource);
  });

  test("Should return a list of MovieCategoryEntity", () async {
    when(() => dataSource.getMoviesCategories(any()))
        .thenAnswer((invocation) async => <GetMovieCategoryModel>[]);

    final result = await repository.selectCategory("action");

    expect(result.fold(id, id), isA<List<MovieCategoriesEntity>>());
  });

  test("Should return InvalidMovieCategory", () async {
    when(() => dataSource.getMoviesCategories(any()))
        .thenThrow(InvalidMovieCategory());

    final result = await repository.selectCategory("action");

    expect(result.fold(id, id), isA<InvalidMovieCategory>());
  });
}
