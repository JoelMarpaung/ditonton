import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  Episode({
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

  @override
  List<Object> get props =>
      [id, name, overview, stillPath!, seasonNumber, episodeNumber];
}
