import 'package:equatable/equatable.dart';

import 'episode.dart';

class SeasonDetail extends Equatable {
  const SeasonDetail({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.episodes,
  });

  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;
  final List<Episode> episodes;

  @override
  List<Object> get props =>
      [id, name, overview, posterPath!, seasonNumber, episodes];
}
