import 'package:movie_app_fteam/app/modules/search/domain/entities/result_search.dart';

abstract class SearchState {}

class SearchStateSuccess implements SearchState {
  final List<ResultSearchEntity> results;

  SearchStateSuccess(this.results);
}

class SearchStateStart implements SearchState {}

class SearchStateLoading implements SearchState {}

class SearchStateError implements SearchState {}
