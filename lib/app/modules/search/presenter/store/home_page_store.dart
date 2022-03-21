import 'package:flutter_triple/flutter_triple.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/movie_category.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/params/search_movies_params.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/result_search.dart';
import 'package:movie_app_fteam/app/modules/search/domain/errors/errors.dart';
import 'package:movie_app_fteam/app/modules/search/domain/usecases/get_movie_categories_usecase.dart';
import 'package:movie_app_fteam/app/modules/search/domain/usecases/search_movie_by_text_usecase.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/store/home_page_widget_state.dart';

class HomePageStore
    extends StreamStore<SearchMoviesException, HomePageWidgetState> {
  final GetMovieCategoriesUseCase getMovieCategoriesUseCase;
  final SearchMovieByTextUseCase searchMoviesByTextUsecase;

  HomePageStore(this.getMovieCategoriesUseCase, this.searchMoviesByTextUsecase)
      : super(HomePageWidgetState());

  Future<void> getMoviesByText(String movieTitle, [int page = 1]) async {
    List<ResultSearchEntity> currentMoviesList = [];

    setLoading(true);

    if (movieTitle.isEmpty) {
      update(state.copyWith(
        movieCategories: state.movieCategories,
        filteredByCategoryResultSearchList: currentMoviesList,
      ));
    }

    final result = await searchMoviesByTextUsecase(
        SearchMoviesParams(movieTitle: movieTitle, page: page));

    result.fold(setError, (r) {
      update(state.copyWith(
          filteredByCategoryResultSearchList: currentMoviesList,
          resultSearchList: currentMoviesList + r));
    });

    setLoading(false);
  }

  Future<void> getMovieCategories() async {
    setLoading(true);

    final results = await getMovieCategoriesUseCase();

    results.fold(setError, ((movieCategory) {
      update(
        state.copyWith(
          movieCategories: [MovieCategoriesEntity('All', -1), ...movieCategory],
        ),
      );
    }));

    setLoading(false);
  }

  Future<void> filterMoviesByCategory(int categoryId) async {
    setLoading(true);

    if (categoryId == -1) {
      update(state.copyWith(
          filteredByCategoryResultSearchList: state.resultSearchList));

      setLoading(false);
      return;
    }

    List<ResultSearchEntity> result = state.resultSearchList
        .where((element) => element.movieCategory.contains(categoryId))
        .toList();

    update(state.copyWith(filteredByCategoryResultSearchList: result));
    setLoading(false);
  }
}
