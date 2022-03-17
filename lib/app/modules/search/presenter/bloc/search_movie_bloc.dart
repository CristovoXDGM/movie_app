import 'package:bloc/bloc.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/params/search_movies_params.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/result_search.dart';

import 'package:movie_app_fteam/app/modules/search/domain/usecases/search_movie_by_text_usecase.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/bloc/events/search_movie_bloc_event.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/bloc/states/search_result_bloc_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchState> {
  final SearchMovieByTextUseCase usecase;

  SearchMovieBloc(this.usecase) : super(SearchStateStart()) {
    on<StartSearchMoviesEvent>(
        (event, emit) => searchMovie(event.movieTitle, emit));
  }

  Future<void> searchMovie(String movieTitle, Emitter emit) async {
    List<ResultSearchEntity> currentMoviesList = [];
    int page = 1;

    if (state is SearchStateSuccess) {
      currentMoviesList = (state as SearchStateSuccess).results;
    }

    emit(SearchStateLoading());

    final result = await usecase
        .call(SearchMoviesParams(movieTitle: movieTitle, page: page));

    result.fold((l) => emit(SearchStateError()), (r) {
      emit(SearchStateSuccess(currentMoviesList + r));
      page++;
    });
  }
}
