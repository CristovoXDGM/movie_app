import 'dart:convert';

import 'package:movie_app_fteam/app/modules/search/domain/entities/movie_category.dart';

class GetMovieCategoryModel extends MovieCategoriesEntity {
  GetMovieCategoryModel({
    required int id,
    required String category,
  }) : super(category, id);

  Map topMap() {
    return {'id': id, 'category': category};
  }

  factory GetMovieCategoryModel.fromMap(Map map) {
    return GetMovieCategoryModel(
        id: map['id'] ?? 0, category: map['name'] ?? '');
  }

  String toJson() => jsonEncode(topMap());

  factory GetMovieCategoryModel.fromJson(source) =>
      GetMovieCategoryModel.fromMap(jsonDecode(source));
}
