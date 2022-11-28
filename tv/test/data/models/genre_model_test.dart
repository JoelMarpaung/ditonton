import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/genre_model.dart';
import 'package:tv/domain/entities/genre.dart';

import '../../json_reader.dart';

void main() {
  const tGenreModel = GenreModel(
      id: 1,
      name: 'Action');

  const tGenre = Genre(
      id: 1,
      name: 'Action');

  test('should be a subclass of Genre entity', () async {
    final result = tGenreModel.toEntity();
    expect(result, tGenre);
  });

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
      json.decode(readJson('dummy_data/Genre_detail.json'));
      // act
      final result = GenreModel.fromJson(jsonMap);
      // assert
      expect(result, tGenreModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tGenreModel.toJson();
      // assert
      final expectedJsonMap = {
        "name": "Action",
        "id": 1
      };
      expect(result, expectedJsonMap);
    });
  });
}
