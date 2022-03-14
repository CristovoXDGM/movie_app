import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/result_search.dart';
import 'package:movie_app_fteam/app/modules/search/domain/errors/errors.dart';
import 'package:movie_app_fteam/app/modules/search/domain/usecases/search_movie_by_text_usecase.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/bloc/events/search_movie_bloc_event.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/bloc/search_movie_bloc.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/bloc/states/search_result_bloc_state.dart';

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
      searchMovieBloc.stream,
      emitsInOrder([
        isA<SearchStateLoading>(),
        isA<SearchStateSuccess>(),
      ]),
    );
    searchMovieBloc.add(StartSearchMoviesEvent(movieTitle: "batman"));
  });
  test("Should return states error", () {
    when(() => usecase.call(any()))
        .thenAnswer((invocation) async => left(InvalidMovieNameError()));

    expect(
      searchMovieBloc.stream,
      emitsInOrder([
        isA<SearchStateLoading>(),
        isA<SearchStateError>(),
      ]),
    );
    searchMovieBloc.add(StartSearchMoviesEvent(movieTitle: "batman"));
  });
}
