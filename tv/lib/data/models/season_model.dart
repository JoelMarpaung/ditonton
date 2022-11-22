import 'package:tv/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class SeasonModel extends Equatable {
  SeasonModel({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.episodeCount,
  });

  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;
  final int episodeCount;

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
        episodeCount: json["episode_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "season_number": seasonNumber,
        "episode_count": episodeCount,
      };

  Season toEntity() {
    return Season(
        id: this.id,
        name: this.name,
        overview: this.overview,
        posterPath: this.posterPath,
        seasonNumber: this.seasonNumber,
        episodeCount: this.episodeCount);
  }

  @override
  List<Object?> get props => [id, name];
}
