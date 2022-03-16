import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/movie_category.dart';
import 'package:movie_app_fteam/app/modules/search/domain/errors/errors.dart';
import 'package:movie_app_fteam/app/modules/search/domain/repositories/get_movie_category_repository.dart';
import 'package:movie_app_fteam/app/modules/search/domain/usecases/get_movie_categories_usecase.dart';

class SelectMovieCategoryRepositoryMock extends Mock
    implements GetMovieCategoriesRepository {}

void main() {
  late GetMovieCategoriesRepository repository;

  late GetMovieCategoriesUseCase usecase;

  setUpAll(() {
    repository = SelectMovieCategoryRepositoryMock();

    usecase = GetMovieCategoriesImpl(repository);
  });

  test("Should return a MovieCategoriesEntity List", () async {
    when(() => repository.getCategories()).thenAnswer(
        (invocation) async => const Right(<MovieCategoriesEntity>[]));

    var results = await usecase();

    expect(results.fold(id, id), isA<List<MovieCategoriesEntity>>());
  });
  test("Should return a CategoriesUnavailable error", () async {
    when(() => repository.getCategories())
        .thenAnswer((invocation) async => Left(CategoriesUnavailable()));

    var results = await usecase();

    expect(results.fold(id, id), isA<CategoriesUnavailable>());
  });
}
