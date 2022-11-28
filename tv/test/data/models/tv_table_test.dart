import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv_table.dart';

void main() {
  const tTvTable = TvTable(id: 1, name: '', posterPath: '', overview: '');

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvTable.toJson();
      // assert
      final expectedJsonMap = {
        "id": 1,
        "name": "",
        "posterPath": "",
        "overview": ""
      };
      expect(result, expectedJsonMap);
    });
  });
}
