import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/tv_now_playing_bloc/tv_now_playing_bloc.dart';
import 'package:tv/presentation/bloc/tv_now_playing_bloc/tv_now_playing_event.dart';
import 'package:tv/presentation/bloc/tv_now_playing_bloc/tv_now_playing_state.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/bloc_helper_test.mocks.dart';

void main() {
  late MockGetNowPlayingTvs _nowPlayingTvs;
  late TvNowPlayingBloc tvNowPlayingBloc;

  setUp(() {
    _nowPlayingTvs = MockGetNowPlayingTvs();
    tvNowPlayingBloc = TvNowPlayingBloc(_nowPlayingTvs);
  });

  test('the initial state should be empty', () {
    expect(tvNowPlayingBloc.state, NowPlayingEmpty());
  });

  blocTest<TvNowPlayingBloc, TvNowPlayingState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(_nowPlayingTvs.execute())
          .thenAnswer((_) async => Right(testTvList));
      return tvNowPlayingBloc;
    },
    act: (bloc) => bloc.add(const OnFetchTvNowPlaying()),
    expect: () => [
      NowPlayingLoading(),
      NowPlayingHasData(testTvList),
    ],
    verify: (bloc) {
      verify(_nowPlayingTvs.execute());
      return const OnFetchTvNowPlaying().props;
    },
  );

  blocTest<TvNowPlayingBloc, TvNowPlayingState>(
    'should emit Loading state and then HasData state when data unsuccessfully fetched',
    build: () {
      when(_nowPlayingTvs.execute())
          .thenAnswer((_) async =>const Left(ServerFailure('Server Failure')));
      return tvNowPlayingBloc;
    },
    act: (bloc) => bloc.add(const OnFetchTvNowPlaying()),
    expect: () => [
      NowPlayingLoading(),
      const NowPlayingError('Server Failure'),
    ],
    verify: (bloc) {
      NowPlayingLoading();
    },
  );
}
