import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:tv/presentation/bloc/tv_detail_bloc/tv_detail_event.dart';
import 'package:tv/presentation/bloc/tv_detail_bloc/tv_detail_state.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/bloc_helper_test.mocks.dart';

void main() {
  late MockGetTvDetail _detailTvs;
  late MockGetTvRecommendations _recommendations;
  late MockGetWatchListStatusTv _status;
  late TvDetailBloc tvDetailBloc;

  const testId = 1;

  setUp(() {
    _detailTvs = MockGetTvDetail();
    _recommendations = MockGetTvRecommendations();
    _status = MockGetWatchListStatusTv();
    tvDetailBloc = TvDetailBloc(_detailTvs, _recommendations, _status);
  });

  test('the initial state should be empty', () {
    expect(tvDetailBloc.state, DetailEmpty());
  });

  blocTest<TvDetailBloc, TvDetailState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(_detailTvs.execute(testId))
          .thenAnswer((_) async => Right(testTvDetail));
      when(_recommendations.execute(testId))
          .thenAnswer((_) async => Right(testTvList));
      when(_status.execute(testId))
          .thenAnswer((_) async => true);
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(const OnFetchTvDetail(testId)),
    expect: () => [
      DetailLoading(),
      DetailHasData(testTvDetail, testTvList, true),
    ],
    verify: (bloc) {
      verify(_detailTvs.execute(testId));
      verify(_recommendations.execute(testId));
      verify(_status.execute(testId));
      return const OnFetchTvDetail(testId).props;
    },
  );

  blocTest<TvDetailBloc, TvDetailState>(
    'should emit Loading state and then HasData state when data unsuccessfully fetched',
    build: () {
      when(_detailTvs.execute(testId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      when(_recommendations.execute(testId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      when(_status.execute(testId))
          .thenAnswer((_) async => false);
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(const OnFetchTvDetail(testId)),
    expect: () => [
      DetailLoading(),
      const DetailError('Server Failure'),
    ],
    verify: (bloc) {
      DetailLoading();
    },
  );
}
