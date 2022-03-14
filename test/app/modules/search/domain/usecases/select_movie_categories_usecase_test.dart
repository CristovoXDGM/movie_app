import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/movie_category.dart';
import 'package:movie_app_fteam/app/modules/search/domain/errors/errors.dart';
import 'package:movie_app_fteam/app/modules/search/domain/repositories/get_movie_category_repository.dart';
import 'package:movie_app_fteam/app/modules/search/domain/usecases/get_movie_categories_usecase.dart';

class SelectMovieCategoryRepositoryMock extends Mock
    implements GetMovieCategoryRepository {}

void main() {
  late GetMovieCategoryRepository repository;

  late GetMovieCategoriesUseCase usecase;

  setUpAll(() {
    repository = SelectMovieCategoryRepositoryMock();

    usecase = SelectMovieCategoryImpl(repository);
  });

  test("Should return a MovieCategoriesEntity List", () async {
    when(() => repository.selectCategory(any())).thenAnswer(
        (invocation) async => const Right(<MovieCategoriesEntity>[]));

    var results = await usecase("action");

    expect(results.fold(id, id), isA<List<MovieCategoriesEntity>>());
  });
  test("Should return a InvalidMovieCategory error", () async {
    when(() => repository.selectCategory(any()))
        .thenAnswer((invocation) async => Left(InvalidMovieCategory()));

    var results = await usecase("");

    expect(results.fold(id, id), isA<InvalidMovieCategory>());
  });
}
