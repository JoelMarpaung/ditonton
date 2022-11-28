import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/season_detail_bloc/season_detail_bloc.dart';
import 'package:tv/presentation/bloc/season_detail_bloc/season_detail_event.dart';
import 'package:tv/presentation/bloc/season_detail_bloc/season_detail_state.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/bloc_helper_test.mocks.dart';

void main() {
  late MockGetSeasonDetail detailSeasons;
  late SeasonDetailBloc seasonDetailBloc;

  const testId = 1;
  const testSeasonNumber = 1;

  setUp(() {
    detailSeasons = MockGetSeasonDetail();
    seasonDetailBloc = SeasonDetailBloc(detailSeasons);
  });

  test('the initial state should be empty', () {
    expect(seasonDetailBloc.state, DetailEmpty());
  });

  blocTest<SeasonDetailBloc, SeasonDetailState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(detailSeasons.execute(testId, testSeasonNumber))
          .thenAnswer((_) async => const Right(testSeasonDetail));
      return seasonDetailBloc;
    },
    act: (bloc) =>
        bloc.add(const OnFetchSeasonDetail(testId, testSeasonNumber)),
    expect: () => [
      DetailLoading(),
      const DetailHasData(testSeasonDetail),
    ],
    verify: (bloc) {
      verify(detailSeasons.execute(testId, testSeasonNumber));
      return const OnFetchSeasonDetail(testId, testSeasonNumber).props;
    },
  );

  blocTest<SeasonDetailBloc, SeasonDetailState>(
    'should emit Loading state and then HasData state when data unsuccessfully fetched',
    build: () {
      when(detailSeasons.execute(testId, testSeasonNumber))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return seasonDetailBloc;
    },
    act: (bloc) =>
        bloc.add(const OnFetchSeasonDetail(testId, testSeasonNumber)),
    expect: () => [
      DetailLoading(),
      const DetailError('Server Failure'),
    ],
    verify: (bloc) {
      DetailLoading();
    },
  );

  blocTest<SeasonDetailBloc, SeasonDetailState>(
    'should emit Loading state and then HasData state when data unsuccessfully fetched',
    build: () {
      when(detailSeasons.execute(testId, testSeasonNumber))
          .thenAnswer((_) async => const Left(SSLFailure('CERTIFICATE_VERIFY_FAILED')));
      return seasonDetailBloc;
    },
    act: (bloc) =>
        bloc.add(const OnFetchSeasonDetail(testId, testSeasonNumber)),
    expect: () => [
      DetailLoading(),
      const DetailError('CERTIFICATE_VERIFY_FAILED'),
    ],
    verify: (bloc) {
      DetailLoading();
    },
  );
}
