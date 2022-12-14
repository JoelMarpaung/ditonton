import 'package:equatable/equatable.dart';

import '../../domain/entities/tv.dart';

class TvModel extends Equatable {
  const TvModel({
    required this.originalLanguage,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.originalName,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? posterPath;
  final double popularity;
  final int id;
  final String? backdropPath;
  final double voteAverage;
  final String overview;
  final List<int> genreIds;
  final String originalLanguage;
  final int voteCount;
  final String name;
  final String originalName;

  factory TvModel.fromJson(Map<String, dynamic> json) => TvModel(
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        originalLanguage: json["original_language"],
        name: json["name"],
        originalName: json["original_name"],
      );

  Tv toEntity() {
    return Tv(
        posterPath: posterPath,
        popularity: popularity,
        id: id,
        backdropPath: backdropPath,
        voteAverage: voteAverage,
        overview: overview,
        genreIds: genreIds,
        originalLanguage: originalLanguage,
        voteCount: voteCount,
        name: name,
        originalName: originalName);
  }

  @override
  List<Object?> get props => [
        posterPath,
        popularity,
        id,
        backdropPath,
        voteAverage,
        overview,
        genreIds,
        originalLanguage,
        voteCount,
        name,
        originalName,
        voteCount,
      ];
}
