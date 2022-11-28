import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv_model.dart';
import 'package:tv/data/models/tv_response.dart';

void main() {
  const tTvModel = TvModel(
      originalLanguage: '',
      backdropPath: '',
      genreIds: [],
      id: 0,
      name: '',
      overview: '',
      popularity: 0,
      posterPath: '',
      originalName: '',
      voteAverage: 0,
      voteCount: 0);

  const tTvResponse = TvResponse(tvList: [tTvModel]);

  test('should be a subclass of Tv entity', () async {
    final result = tTvResponse.props;
    expect(result, [tTvModel]);
  });
}
