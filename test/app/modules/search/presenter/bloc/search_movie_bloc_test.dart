import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/params/search_movies_params.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/result_search.dart';
import 'package:movie_app_fteam/app/modules/search/domain/errors/errors.dart';
import 'package:movie_app_fteam/app/modules/search/domain/usecases/search_movie_by_text_usecase.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/bloc/events/search_movie_bloc_event.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/bloc/search_movie_bloc.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/bloc/states/search_result_bloc_state.dart';

class SearchMovieByTextUseCaseMock extends Mock
    implements SearchMovieByTextUseCase {}

void main() {
  late SearchMovieBloc searchMovieBloc;
  late SearchMovieByTextUseCase usecase;

  setUpAll(() {
    usecase = SearchMovieByTextUseCaseMock();
    searchMovieBloc = SearchMovieBloc(usecase);
    registerFallbackValue(SearchMoviesParams());
  });

  blocTest<SearchMovieBloc, SearchState>(
      'Should return states in the correct order',
      build: () {
        when(() => usecase.call(any()))
            .thenAnswer((invocation) async => right(<ResultSearchEntity>[]));
        return searchMovieBloc;
      },
      act: (bloc) => bloc.add(StartSearchMoviesEvent(movieTitle: 'batman')),
      expect: () => [isA<SearchStateLoading>(), isA<SearchStateSuccess>()]);

  blocTest<SearchMovieBloc, SearchState>('Should return states error',
      build: () {
        when(() => usecase.call(any()))
            .thenAnswer((invocation) async => left(InvalidMovieNameError()));
        return SearchMovieBloc(usecase);
      },
      act: (bloc) => bloc.add(StartSearchMoviesEvent(movieTitle: 'batman')),
      expect: () => [isA<SearchStateLoading>(), isA<SearchStateError>()]);
}
