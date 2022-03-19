import 'package:dartz/dartz.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/result_search.dart';
import 'package:movie_app_fteam/app/modules/search/domain/errors/errors.dart';
import 'package:movie_app_fteam/app/modules/search/infra/models/result_search_movie_model.dart';

abstract class GetMoviesDatasource {
  Future<List<ResultSearchMovieModel>> getMovies();
}
