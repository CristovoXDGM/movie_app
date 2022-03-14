import 'dart:convert';

import 'package:movie_app_fteam/app/modules/search/domain/entities/result_search.dart';

class ResultSearchMovieModel extends ResultSearchEntity {
  ResultSearchMovieModel({
    required String movieImage,
    required String movieTitle,
    required String movieCategory,
    required String movieLevel,
    required String movieAccent,
    required String movieRating,
  }) : super(
            movieImage: '',
            movieTitle: '',
            movieCategory: '',
            movieLevel: '',
            movieAccent: '',
            movieRating: '');

  Map<String, dynamic> toMap() {
    return {
      'movieImage': movieImage,
      'movieTitle': movieTitle,
      'movieCategory': movieCategory,
      'movieLevel': movieLevel,
      'movieAccent': movieAccent,
      'movieRating': movieRating,
    };
  }

  factory ResultSearchMovieModel.fromMap(Map<String, dynamic> map) {
    return ResultSearchMovieModel(
      movieImage: map['movieImage'] ?? '',
      movieTitle: map['movieTitle'] ?? '',
      movieCategory: map['movieCategory'] ?? '',
      movieLevel: map['movieLevel'] ?? '',
      movieAccent: map['movieAccent'] ?? '',
      movieRating: map['movieRating'] ?? '',
    );
  }

  String toJson() => jsonEncode(toMap());

  factory ResultSearchMovieModel.fromJson(String source) =>
      ResultSearchMovieModel.fromMap(json.decode(source));
}
