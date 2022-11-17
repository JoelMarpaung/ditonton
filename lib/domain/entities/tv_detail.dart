import 'package:ditonton/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

import 'genre.dart';

class TvDetail extends Equatable {
  TvDetail(
      {required this.posterPath,
      required this.popularity,
      required this.id,
      required this.backdropPath,
      required this.voteAverage,
      required this.overview,
      required this.genres,
      required this.seasons,
      required this.originalLanguage,
      required this.voteCount,
      required this.name,
      required this.originalName});

  String? posterPath;
  double? popularity;
  int id;
  String? backdropPath;
  double? voteAverage;
  String? overview;
  List<Genre> genres;
  List<Season> seasons;
  String? originalLanguage;
  int? voteCount;
  String? name;
  String? originalName;

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
      ];
}
