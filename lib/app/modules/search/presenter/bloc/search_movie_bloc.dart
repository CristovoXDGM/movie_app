import 'package:bloc/bloc.dart';
import 'package:movie_app_fteam/app/modules/search/domain/usecases/search_movie_by_text.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/bloc/state/search_result_bloc_state.dart';

class SearchMovieBloc extends Bloc<String, SearchState> {
  final SearchMovieByTextUseCase usecase;

  SearchMovieBloc(this.usecase) : super(SearchStateStart()) {
    on((event, emit) => emit(SearchStateLoading()));
  }
}
