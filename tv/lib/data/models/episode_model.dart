import 'package:tv/domain/entities/episode.dart';
import 'package:equatable/equatable.dart';

class EpisodeModel extends Equatable {
  EpisodeModel({
    required this.id,
    required this.name,
    required this.overview,
    required this.stillPath,
    required this.seasonNumber,
    required this.episodeNumber,
  });

  final int id;
  final String name;
  final String overview;
  final String? stillPath;
  final int seasonNumber;
  final int episodeNumber;

  factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        stillPath: json["still_path"],
        seasonNumber: json["season_number"],
        episodeNumber: json["episode_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "overview": overview,
        "still_path": stillPath,
        "season_number": seasonNumber,
        "episode_number": episodeNumber,
      };

  Episode toEntity() {
    return Episode(
        id: this.id,
        name: this.name,
        overview: this.overview,
        stillPath: this.stillPath,
        seasonNumber: this.seasonNumber,
        episodeNumber: this.episodeNumber);
  }

  @override
  List<Object> get props =>
      [id, name, overview, stillPath!, seasonNumber, episodeNumber];
}
