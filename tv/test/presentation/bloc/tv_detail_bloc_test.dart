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
  late MockGetTvDetail detailTvs;
  late MockGetTvRecommendations recommendations;
  late MockGetWatchListStatusTv status;
  late TvDetailBloc tvDetailBloc;

  const testId = 1;

  setUp(() {
    detailTvs = MockGetTvDetail();
    recommendations = MockGetTvRecommendations();
    status = MockGetWatchListStatusTv();
    tvDetailBloc = TvDetailBloc(detailTvs, recommendations, status);
  });

  test('the initial state should be empty', () {
    expect(tvDetailBloc.state, DetailEmpty());
  });

  blocTest<TvDetailBloc, TvDetailState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(detailTvs.execute(testId))
          .thenAnswer((_) async => Right(testTvDetail));
      when(recommendations.execute(testId))
          .thenAnswer((_) async => Right(testTvList));
      when(status.execute(testId)).thenAnswer((_) async => true);
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(const OnFetchTvDetail(testId)),
    expect: () => [
      DetailLoading(),
      DetailHasData(testTvDetail, testTvList, true),
    ],
    verify: (bloc) {
      verify(detailTvs.execute(testId));
      verify(recommendations.execute(testId));
      verify(status.execute(testId));
      return const OnFetchTvDetail(testId).props;
    },
  );

  blocTest<TvDetailBloc, TvDetailState>(
    'should emit Loading state and then HasData state when data unsuccessfully fetched',
    build: () {
      when(detailTvs.execute(testId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      when(recommendations.execute(testId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      when(status.execute(testId)).thenAnswer((_) async => false);
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
