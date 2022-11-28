import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/season_detail_model.dart';

void main() {
  const tSeasonModel = SeasonDetailModel(
      id: 3624,
      name: 'Season 1',
      overview: 'overview',
      posterPath: '/path.jpg',
      seasonNumber: 1, episodes: []);

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
        "season_number": 1
      };
      expect(result, expectedJsonMap);
    });
  });
}
