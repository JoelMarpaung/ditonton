import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/tv_top_rated_bloc/tv_top_rated_bloc.dart';
import 'package:tv/presentation/bloc/tv_top_rated_bloc/tv_top_rated_event.dart';
import 'package:tv/presentation/bloc/tv_top_rated_bloc/tv_top_rated_state.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/bloc_helper_test.mocks.dart';

void main() {
  late MockGetTopRatedTvs topRatedTvs;
  late TvTopRatedBloc tvTopRatedBloc;

  setUp(() {
    topRatedTvs = MockGetTopRatedTvs();
    tvTopRatedBloc = TvTopRatedBloc(topRatedTvs);
  });

  test('the initial state should be empty', () {
    expect(tvTopRatedBloc.state, TopRatedEmpty());
  });

  blocTest<TvTopRatedBloc, TvTopRatedState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(topRatedTvs.execute())
          .thenAnswer((_) async => Right(testTvList));
      return tvTopRatedBloc;
    },
    act: (bloc) => bloc.add(const OnFetchTvTopRated()),
    expect: () => [
      TopRatedLoading(),
      TopRatedHasData(testTvList),
    ],
    verify: (bloc) {
      verify(topRatedTvs.execute());
      return const OnFetchTvTopRated().props;
    },
  );

  blocTest<TvTopRatedBloc, TvTopRatedState>(
    'should emit Loading state and then HasData state when data unsuccessfully fetched',
    build: () {
      when(topRatedTvs.execute())
          .thenAnswer((_) async =>const Left(ServerFailure('Server Failure')));
      return tvTopRatedBloc;
    },
    act: (bloc) => bloc.add(const OnFetchTvTopRated()),
    expect: () => [
      TopRatedLoading(),
      const TopRatedError('Server Failure'),
    ],
    verify: (bloc) {
      TopRatedLoading();
    },
  );
}
