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
  late MockGetSeasonDetail _detailSeasons;
  late SeasonDetailBloc seasonDetailBloc;

  const testId = 1;
  const testSeasonNumber = 1;

  setUp(() {
    _detailSeasons = MockGetSeasonDetail();
    seasonDetailBloc = SeasonDetailBloc(_detailSeasons);
  });

  test('the initial state should be empty', () {
    expect(seasonDetailBloc.state, DetailEmpty());
  });

  blocTest<SeasonDetailBloc, SeasonDetailState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(_detailSeasons.execute(testId, testSeasonNumber))
          .thenAnswer((_) async => Right(testSeasonDetail));
      return seasonDetailBloc;
    },
    act: (bloc) => bloc.add(const OnFetchSeasonDetail(testId, testSeasonNumber)),
    expect: () => [
      DetailLoading(),
      DetailHasData(testSeasonDetail),
    ],
    verify: (bloc) {
      verify(_detailSeasons.execute(testId, testSeasonNumber));
      return const OnFetchSeasonDetail(testId, testSeasonNumber).props;
    },
  );

  blocTest<SeasonDetailBloc, SeasonDetailState>(
    'should emit Loading state and then HasData state when data unsuccessfully fetched',
    build: () {
      when(_detailSeasons.execute(testId, testSeasonNumber))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return seasonDetailBloc;
    },
    act: (bloc) => bloc.add(const OnFetchSeasonDetail(testId, testSeasonNumber)),
    expect: () => [
      DetailLoading(),
      const DetailError('Server Failure'),
    ],
    verify: (bloc) {
      DetailLoading();
    },
  );
}
