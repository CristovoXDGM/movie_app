import 'package:movie_app_fteam/app/modules/search/domain/entities/movie_category.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/result_search.dart';

class HomePageWidgetState {
  final List<ResultSearchEntity> resultSearchList;
  final List<ResultSearchEntity> filteredByCategoryResultSearchList;
  final List<MovieCategoriesEntity> movieCategories;

  HomePageWidgetState(
      {this.resultSearchList = const [],
      this.filteredByCategoryResultSearchList = const [],
      this.movieCategories = const []});

  HomePageWidgetState copyWith({
    List<ResultSearchEntity>? resultSearchList,
    List<ResultSearchEntity>? filteredByCategoryResultSearchList,
    List<MovieCategoriesEntity>? movieCategories,
  }) {
    return HomePageWidgetState(
      resultSearchList: resultSearchList ?? this.resultSearchList,
      filteredByCategoryResultSearchList: filteredByCategoryResultSearchList ??
          this.filteredByCategoryResultSearchList,
      movieCategories: movieCategories ?? this.movieCategories,
    );
  }
}
