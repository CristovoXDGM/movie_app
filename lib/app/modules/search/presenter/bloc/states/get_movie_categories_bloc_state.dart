import 'package:movie_app_fteam/app/modules/search/domain/entities/movie_category.dart';

abstract class GetMovieCategoriesState {}

class StartGetCategories implements GetMovieCategoriesState {}

class SuccessGetCategories implements GetMovieCategoriesState {
  final List<MovieCategoriesEntity> results;

  SuccessGetCategories(this.results);
}

class LoadingGetCategories implements GetMovieCategoriesState {}

class ErrorGetCategories implements GetMovieCategoriesState {}
