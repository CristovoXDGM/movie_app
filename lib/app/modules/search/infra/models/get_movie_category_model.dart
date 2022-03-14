import 'dart:convert';

import 'package:movie_app_fteam/app/modules/search/domain/entities/movie_category.dart';

class GetMovieCategoryModel extends MovieCategoriesEntity {
  GetMovieCategoryModel({required String category, required int id})
      : super(category, id);

  Map<String, dynamic> topMap() {
    return {"id": id, "category": category};
  }

  factory GetMovieCategoryModel.fromMap(Map<String, dynamic> map) {
    return GetMovieCategoryModel(category: map["name"], id: map["id"]);
  }

  String toJson() => jsonEncode(topMap());

  factory GetMovieCategoryModel.fromJsonm(String source) =>
      GetMovieCategoryModel.fromMap(jsonDecode(source));
}
