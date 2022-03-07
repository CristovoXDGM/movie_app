import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/result_search.dart';
import 'package:movie_app_fteam/app/modules/search/domain/errors/errors.dart';
import 'package:movie_app_fteam/app/modules/search/domain/repositories/search_movie_repository.dart';
import 'package:movie_app_fteam/app/modules/search/domain/usecases/search_movie_by_text.dart';

class SearchRepositoryMock extends Mock implements SearchMovieRepository {}

void main() {
  late SearchMovieRepository repository;

  late SearchMovieByTextUseCase usecase;

  setUpAll(() {
    repository = SearchRepositoryMock();
    usecase = SearchMovieByTextImpl(searchMovieRepository: repository);
  });

  test("Should return a list from ResultSearchEntity", () async {
    when(() => repository.search(any()))
        .thenAnswer((invocation) async => const Right(<ResultSearchEntity>[]));
    var result = await usecase("movie name");
    expect(result, isA<Right>());
    expect(result | List<ResultSearchEntity>.empty(),
        isA<List<ResultSearchEntity>>());
  });

  test("Should return a SearchMoviesException", () async {
    when(() => repository.search(any()))
        .thenAnswer((invocation) async => const Right(<ResultSearchEntity>[]));
    var result = await usecase("");
    expect(result.isLeft(), true);
    expect(result.fold(id, id), isA<InvalidMovieNameError>());
  });
}
