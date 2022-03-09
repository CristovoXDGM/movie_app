import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app_fteam/app/modules/search/domain/usecases/search_movie_by_text.dart';
import 'package:movie_app_fteam/app/modules/search/external/datasource/tmdb_datasource.dart';
import 'package:movie_app_fteam/app/modules/search/infra/repositories/search_movie_repo_Impl.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => Dio()),
        Bind.factory((i) => SearchMovieByTextImpl(i())),
        Bind.factory((i) => SearchRepositoryImpl(i())),
        Bind.factory((i) => TmdbDataSource(i())),
      ];

  @override
  List<ModularRoute> get routes => [];
}
