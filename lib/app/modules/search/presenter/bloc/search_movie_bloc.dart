import 'package:bloc/bloc.dart';
import 'package:movie_app_fteam/app/modules/search/domain/usecases/search_movie_by_text.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/bloc/events/search_movie_bloc_event.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/bloc/states/search_result_bloc_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchState> {
  final SearchMovieByTextUseCase usecase;

  SearchMovieBloc(this.usecase) : super(SearchStateStart()) {
    on<StartSearchMoviesEvent>(
        (event, emit) => searchMovie(event.movieTitle, emit));
  }

  void searchMovie(String movieTitle, Emitter emit) async {
    emit(SearchStateLoading());

    final result = await usecase.call(movieTitle);

    result.fold(
        (l) => emit(SearchStateError()), (r) => emit(SearchStateSuccess(r)));
  }
}
