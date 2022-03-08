import 'package:dio/dio.dart';
import 'package:movie_app_fteam/app/modules/search/infra/datasource/search_movie_datasource.dart';
import 'package:movie_app_fteam/app/modules/search/infra/models/result_search_movie_model.dart';

class TmdbDataSource implements SearchDataSource {
  final Dio dio;

  TmdbDataSource(this.dio);

  @override
  Future<List<ResultSearchMovieModel>> getSearchMovie(String? movieTitle) {
    throw UnimplementedError();
  }
}
