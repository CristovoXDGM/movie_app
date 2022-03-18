import 'package:bloc/bloc.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/movie_category.dart';
import 'package:movie_app_fteam/app/modules/search/domain/usecases/get_movie_categories_usecase.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/bloc/events/get_movie_categories_event.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/bloc/states/get_movie_categories_bloc_state.dart';

class GetMovieCategoriesBloc
    extends Bloc<GetMovieCategoriesEvent, GetMovieCategoriesState> {
  final GetMovieCategoriesUseCase useCase;

  GetMovieCategoriesBloc(this.useCase) : super(StartGetCategories()) {
    on<LoadMovieCategories>((event, emit) => loadMovieCategories(event, emit));
  }

  void loadMovieCategories(GetMovieCategoriesEvent event, Emitter emit) async {
    emit(LoadingGetCategories());

    final result = await useCase.call();

    result.fold(
      (categoryException) => emit(ErrorGetCategories()),
      (movieCategory) => emit(
        SuccessGetCategories(
            [MovieCategoriesEntity('All', -1), ...movieCategory]),
      ),
    );
  }
}
