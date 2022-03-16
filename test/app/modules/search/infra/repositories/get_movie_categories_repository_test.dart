import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/movie_category.dart';
import 'package:movie_app_fteam/app/modules/search/domain/errors/errors.dart';
import 'package:movie_app_fteam/app/modules/search/domain/repositories/get_movie_category_repository.dart';
import 'package:movie_app_fteam/app/modules/search/infra/datasource/get_movie_categories_datasource.dart';
import 'package:movie_app_fteam/app/modules/search/infra/models/get_movie_category_model.dart';
import 'package:movie_app_fteam/app/modules/search/infra/repositories/get_movie_category_repository.dart';

class GetMovieCategoryDatasourceMock extends Mock
    implements GetMovieCategoryDataSource {}

void main() {
  late GetMovieCategoryDataSource dataSource;
  late GetMovieCategoriesRepository repository;

  setUpAll(() {
    dataSource = GetMovieCategoryDatasourceMock();
    repository = GetMovieCategoryRepositoryImpl(dataSource);
  });

  test("Should return a list of MovieCategoryEntity", () async {
    when(() => dataSource.getMovieCategories())
        .thenAnswer((invocation) async => <GetMovieCategoryModel>[]);

    final result = await repository.getCategories();

    expect(result.fold(id, id), isA<List<MovieCategoriesEntity>>());
  });

  test("Should return InvalidMovieCategory", () async {
    when(() => dataSource.getMovieCategories())
        .thenThrow(CategoriesUnavailable());

    final result = await repository.getCategories();

    expect(result.fold(id, id), isA<CategoriesUnavailable>());
  });
}
