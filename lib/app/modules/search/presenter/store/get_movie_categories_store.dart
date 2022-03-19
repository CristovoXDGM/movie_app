import 'package:flutter_triple/flutter_triple.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/movie_category.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/result_search.dart';
import 'package:movie_app_fteam/app/modules/search/domain/errors/errors.dart';
import 'package:movie_app_fteam/app/modules/search/domain/usecases/get_movie_categories_usecase.dart';

class GetMovieCategoriesStore
    extends StreamStore<CategoriesUnavailable, List<MovieCategoriesEntity>> {
  final GetMovieCategoriesUseCase useCase;

  GetMovieCategoriesStore(this.useCase) : super([]);

  Future<void> getMovieCategories() async {
    setLoading(true);

    final results = await useCase();

    results.fold(setError, update);

    setLoading(false);
  }
}
