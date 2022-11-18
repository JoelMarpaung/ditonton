import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/Season.dart';
import 'package:ditonton/domain/usecases/get_season_detail.dart';
import 'package:ditonton/presentation/provider/season_detail_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'season_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetSeasonDetail,
])
void main() {
  late SeasonDetailNotifier provider;
  late MockGetSeasonDetail mockGetSeasonDetail;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetSeasonDetail = MockGetSeasonDetail();
    provider = SeasonDetailNotifier(
      getSeasonDetail: mockGetSeasonDetail,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;
  final tSeasonNumber = 1;

  final tSeason = Season(
    id: 0,
    overview: '',
    posterPath: '',
    name: '',
    seasonNumber: 0,
    episodeCount: 0,
  );
  final tSeasons = <Season>[tSeason];

  void _arrangeUsecase() {
    when(mockGetSeasonDetail.execute(tId, tSeasonNumber))
        .thenAnswer((_) async => Right(testSeasonDetail));
  }

  group('Get Season Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchSeasonDetail(tId, tSeasonNumber);
      // assert
      verify(mockGetSeasonDetail.execute(tId, tSeasonNumber));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchSeasonDetail(tId, tSeasonNumber);
      // assert
      expect(provider.seasonState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change Season when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchSeasonDetail(tId, tSeasonNumber);
      // assert
      expect(provider.seasonState, RequestState.Loaded);
      expect(provider.season, testSeasonDetail);
      expect(listenerCallCount, 2);
    });
  });
}
