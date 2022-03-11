import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/result_search.dart';
import 'package:movie_app_fteam/app/modules/search/domain/usecases/search_movie_by_text.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/bloc/search_movie_bloc.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/bloc/state/search_result_bloc_state.dart';

class SearchMovieByTextMock extends Mock implements SearchMovieByTextUseCase {}

void main() {
  late SearchMovieBloc searchMovieBloc;
  late SearchMovieByTextUseCase usecase;

  setUpAll(() {
    usecase = SearchMovieByTextMock();
    searchMovieBloc = SearchMovieBloc(usecase);
  });

  test("Should return states in the correct order", () {
    when(() => usecase.call("batman"))
        .thenAnswer((invocation) async => right(<ResultSearchEntity>[]));

    expect(
      searchMovieBloc,
      emitsInOrder([
        isA<SearchStateStart>(),
        isA<SearchStateLoading>(),
        isA<SearchStateSuccess>(),
      ]),
    );
    searchMovieBloc.add("batman");
  });
}
