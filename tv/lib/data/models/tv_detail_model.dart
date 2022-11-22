import 'package:tv/data/models/season_model.dart';
import 'package:equatable/equatable.dart';

import 'package:tv/domain/entities/tv_detail.dart';
import 'genre_model.dart';

class TvDetailResponse extends Equatable {
  const TvDetailResponse({
    required this.originalLanguage,
    required this.backdropPath,
    required this.genres,
    required this.seasons,
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
  final List<GenreModel> genres;
  final List<SeasonModel> seasons;
  final String originalLanguage;
  final int voteCount;
  final String name;
  final String originalName;

  factory TvDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvDetailResponse(
        backdropPath: json["backdrop_path"],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        seasons: List<SeasonModel>.from(
            json["seasons"].map((x) => SeasonModel.fromJson(x))),
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

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
        "id": id,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "original_language": originalLanguage,
        "name": name,
        "original_name": originalName,
      };

  TvDetail toEntity() {
    return TvDetail(
        posterPath: posterPath,
        popularity: popularity,
        id: id,
        backdropPath: backdropPath,
        voteAverage: voteAverage,
        overview: overview,
        genres: genres.map((genre) => genre.toEntity()).toList(),
        seasons: seasons.map((season) => season.toEntity()).toList(),
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
        genres,
        seasons,
        originalLanguage,
        voteCount,
        name,
        originalName,
        voteCount,
      ];
}
