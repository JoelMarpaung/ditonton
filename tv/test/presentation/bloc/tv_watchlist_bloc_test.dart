import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/tv_watchlist_bloc/tv_watchlist_bloc.dart';
import 'package:tv/presentation/bloc/tv_watchlist_bloc/tv_watchlist_event.dart';
import 'package:tv/presentation/bloc/tv_watchlist_bloc/tv_watchlist_state.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/bloc_helper_test.mocks.dart';

void main() {
  late MockGetWatchlistTvs _watchlistTvs;
  late MockGetWatchListStatusTv _status;
  late MockSaveWatchlistTv _saveWatchlist;
  late MockRemoveWatchlistTv _removeWatchlist;
  late TvWatchlistBloc tvWatchlistBloc;

  const testId = 1;

  setUp(() {
    _watchlistTvs = MockGetWatchlistTvs();
    _status = MockGetWatchListStatusTv();
    _saveWatchlist = MockSaveWatchlistTv();
    _removeWatchlist = MockRemoveWatchlistTv();
    tvWatchlistBloc = TvWatchlistBloc(
        _watchlistTvs, _saveWatchlist, _removeWatchlist, _status);
  });

  test('the initial state should be empty', () {
    expect(tvWatchlistBloc.state, WatchlistEmpty());
  });

  group('OnFetchTvWatchlist', () {
    blocTest<TvWatchlistBloc, TvWatchlistState>(
      'should emit Loading state and then HasData state when data successfully fetched',
      build: () {
        when(_watchlistTvs.execute())
            .thenAnswer((_) async => Right(testTvList));
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(const OnFetchTvWatchlist()),
      expect: () => [
        WatchlistLoading(),
        WatchlistHasData(testTvList),
      ],
      verify: (bloc) {
        verify(_watchlistTvs.execute());
        return const OnFetchTvWatchlist().props;
      },
    );

    blocTest<TvWatchlistBloc, TvWatchlistState>(
      'should emit Loading state and then HasData state when data unsuccessfully fetched',
      build: () {
        when(_watchlistTvs.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(const OnFetchTvWatchlist()),
      expect: () => [
        WatchlistLoading(),
        const WatchlistError('Server Failure'),
      ],
      verify: (bloc) {
        WatchlistLoading();
      },
    );
  });

  group('OnWatchlistTvStatus', () {
    blocTest<TvWatchlistBloc, TvWatchlistState>(
      'should emit Loading state and then HasData state when data successfully fetched',
      build: () {
        when(_status.execute(testId)).thenAnswer((_) async => true);
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(const OnWatchlistTvStatus(testId)),
      expect: () => [
        WatchlistState(true),
      ],
      verify: (bloc) {
        verify(_status.execute(testId));
        return const OnWatchlistTvStatus(testId).props;
      },
    );
  });

  group('OnAddWatchlistTv', () {
    blocTest<TvWatchlistBloc, TvWatchlistState>(
      'should emit Loading state and then HasData state when data successfully fetched',
      build: () {
        when(_saveWatchlist.execute(testTvDetail))
            .thenAnswer((_) async => const Right(watchlistAddSuccessMessage));
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(OnAddWatchlistTv(testTvDetail)),
      expect: () => [
        WatchlistState(true),
      ],
      verify: (bloc) {
        verify(_saveWatchlist.execute(testTvDetail));
        return OnAddWatchlistTv(testTvDetail).props;
      },
    );

    blocTest<TvWatchlistBloc, TvWatchlistState>(
      'should emit Loading state and then HasData state when data unsuccessfully fetched',
      build: () {
        when(_saveWatchlist.execute(testTvDetail))
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(OnAddWatchlistTv(testTvDetail)),
      expect: () => [
        const WatchlistError('Server Failure'),
      ],
      verify: (bloc) {
        WatchlistLoading();
      },
    );
  });

  group('OnRemoveWatchlistTv', () {
    blocTest<TvWatchlistBloc, TvWatchlistState>(
      'should emit Loading state and then HasData state when data successfully fetched',
      build: () {
        when(_removeWatchlist.execute(testTvDetail))
            .thenAnswer((_) async => const Right(watchlistRemoveSuccessMessage));
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(OnRemoveWatchlistTv(testTvDetail)),
      expect: () => [
        WatchlistState(false),
      ],
      verify: (bloc) {
        verify(_removeWatchlist.execute(testTvDetail));
        return OnRemoveWatchlistTv(testTvDetail).props;
      },
    );

    blocTest<TvWatchlistBloc, TvWatchlistState>(
      'should emit Loading state and then HasData state when data unsuccessfully fetched',
      build: () {
        when(_removeWatchlist.execute(testTvDetail))
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(OnRemoveWatchlistTv(testTvDetail)),
      expect: () => [
        const WatchlistError('Server Failure'),
      ],
      verify: (bloc) {
        WatchlistLoading();
      },
    );
  });
}
