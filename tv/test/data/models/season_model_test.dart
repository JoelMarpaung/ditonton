import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/season_model.dart';
import 'package:tv/domain/entities/season.dart';


void main() {
  const tSeasonModel = SeasonModel(
      id: 3624,
      name: 'Season 1',
      overview: 'overview',
      posterPath: '/path.jpg',
      seasonNumber: 1,
      episodeCount: 1);

  const tSeason = Season(
      id: 3624,
      name: 'Season 1',
      overview: 'overview',
      posterPath: '/path.jpg',
      seasonNumber: 1,
      episodeCount: 1);

  test('should be a subclass of Season entity', () async {
    final result = tSeasonModel.toEntity();
    expect(result, tSeason);
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tSeasonModel.toJson();
      // assert
      final expectedJsonMap = {
        "id": 3624,
        "name": 'Season 1',
        "overview": 'overview',
        "poster_path": '/path.jpg',
        "season_number": 1,
        "episode_count": 1
      };
      expect(result, expectedJsonMap);
    });
  });
}
