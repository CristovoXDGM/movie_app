import 'dart:convert';

import 'package:movie_app_fteam/app/modules/search/domain/entities/result_search.dart';

class ResultSearchMovieModel extends ResultSearchEntity {
  final String movieImage;
  final String movieTitle;
  final String movieCategory;
  final String movieLevel;
  final String movieAccent;
  final String movieRating;
  ResultSearchMovieModel({
    required this.movieImage,
    required this.movieTitle,
    required this.movieCategory,
    required this.movieLevel,
    required this.movieAccent,
    required this.movieRating,
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

  String toJson() => json.encode(toMap());

  factory ResultSearchMovieModel.fromJson(String source) =>
      ResultSearchMovieModel.fromMap(json.decode(source));
}
