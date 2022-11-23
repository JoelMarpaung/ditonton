import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/tv_popular_bloc/tv_popular_bloc.dart';
import 'package:tv/presentation/bloc/tv_popular_bloc/tv_popular_event.dart';
import 'package:tv/presentation/bloc/tv_popular_bloc/tv_popular_state.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/bloc_helper_test.mocks.dart';

void main() {
  late MockGetPopularTvs popularTvs;
  late TvPopularBloc tvPopularBloc;

  setUp(() {
    popularTvs = MockGetPopularTvs();
    tvPopularBloc = TvPopularBloc(popularTvs);
  });

  test('the initial state should be empty', () {
    expect(tvPopularBloc.state, PopularEmpty());
  });

  blocTest<TvPopularBloc, TvPopularState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(popularTvs.execute()).thenAnswer((_) async => Right(testTvList));
      return tvPopularBloc;
    },
    act: (bloc) => bloc.add(const OnFetchTvPopular()),
    expect: () => [
      PopularLoading(),
      PopularHasData(testTvList),
    ],
    verify: (bloc) {
      verify(popularTvs.execute());
      return const OnFetchTvPopular().props;
    },
  );

  blocTest<TvPopularBloc, TvPopularState>(
    'should emit Loading state and then HasData state when data unsuccessfully fetched',
    build: () {
      when(popularTvs.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvPopularBloc;
    },
    act: (bloc) => bloc.add(const OnFetchTvPopular()),
    expect: () => [
      PopularLoading(),
      const PopularError('Server Failure'),
    ],
    verify: (bloc) {
      PopularLoading();
    },
  );
}
