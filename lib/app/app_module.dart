import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app_fteam/app/modules/search/domain/usecases/get_movie_categories_usecase.dart';
import 'package:movie_app_fteam/app/modules/search/domain/usecases/search_movie_by_text_usecase.dart';
import 'package:movie_app_fteam/app/modules/search/external/datasource/tmdb_get_movies_categories.dart';
import 'package:movie_app_fteam/app/modules/search/external/datasource/tmdb_search_movies_by_text_datasource.dart';
import 'package:movie_app_fteam/app/modules/search/infra/repositories/get_movie_category_repository.dart';
import 'package:movie_app_fteam/app/modules/search/infra/repositories/search_movie_repo_Impl.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/store/get_movie_categories_store.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/store/search_movies_by_text_store.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/widgets/pages/home_page_widget.dart';
import 'package:uno/uno.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => Uno()),
        Bind.factory((i) => SearchMovieByTextImpl(i())),
        Bind.factory((i) => SearchRepositoryImpl(i())),
        Bind.factory((i) => SearchMoviesByTextStore(i())),
        Bind.factory((i) => TmdbSearchMoviesByTextDataSource(i())),
        Bind.factory((i) => GetMovieCategoriesStore(i())),
        Bind.factory((i) => GetMovieCategoriesImpl(i())),
        Bind.factory((i) => GetMovieCategoryRepositoryImpl(i())),
        Bind.factory((i) => TmdbGetMovieCategoriesDataSource(i())),
      ];
  // create a search module for every module with every bing and call only current module the
  @override
  List<ModularRoute> get routes =>
      [ChildRoute('/', child: (context, args) => const HomePageWidget())];
}
