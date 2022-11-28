import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/episode_model.dart';
import 'package:tv/domain/entities/episode.dart';

import '../../json_reader.dart';

void main() {
  const tEpisodeModel = EpisodeModel(
      id: 63056,
      name: 'Winter Is Coming',
      overview: 'overview',
      stillPath: '/path.jpg',
      seasonNumber: 1,
      episodeNumber: 1);

  const tEpisode = Episode(
      id: 63056,
      name: 'Winter Is Coming',
      overview: 'overview',
      stillPath: '/path.jpg',
      seasonNumber: 1,
      episodeNumber: 1);

  test('should be a subclass of Episode entity', () async {
    final result = tEpisodeModel.toEntity();
    expect(result, tEpisode);
  });

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
      json.decode(readJson('dummy_data/episode_detail.json'));
      // act
      final result = EpisodeModel.fromJson(jsonMap);
      // assert
      expect(result, tEpisodeModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tEpisodeModel.toJson();
      // assert
      final expectedJsonMap = {
        "episode_number": 1,
        "name": "Winter Is Coming",
        "overview": "overview",
        "id": 63056,
        "season_number": 1,
        "still_path": "/path.jpg"
      };
      expect(result, expectedJsonMap);
    });
  });
}
