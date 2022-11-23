import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/movie_watchlist_bloc/movie_watchlist_bloc.dart';
import 'package:movie/presentation/bloc/movie_watchlist_bloc/movie_watchlist_event.dart';
import 'package:movie/presentation/bloc/movie_watchlist_bloc/movie_watchlist_state.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/bloc_helper_test.mocks.dart';

void main() {
  late MockGetWatchlistMovies _watchlistMovies;
  late MockGetWatchListStatus _status;
  late MockSaveWatchlist _saveWatchlist;
  late MockRemoveWatchlist _removeWatchlist;
  late MovieWatchlistBloc movieWatchlistBloc;

  const testId = 1;

  setUp(() {
    _watchlistMovies = MockGetWatchlistMovies();
    _status = MockGetWatchListStatus();
    _saveWatchlist = MockSaveWatchlist();
    _removeWatchlist = MockRemoveWatchlist();
    movieWatchlistBloc = MovieWatchlistBloc(
        _watchlistMovies, _saveWatchlist, _removeWatchlist, _status);
  });

  test('the initial state should be empty', () {
    expect(movieWatchlistBloc.state, WatchlistEmpty());
  });

  group('OnFetchMovieWatchlist', () {
    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'should emit Loading state and then HasData state when data successfully fetched',
      build: () {
        when(_watchlistMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(const OnFetchMovieWatchlist()),
      expect: () => [
        WatchlistLoading(),
        WatchlistHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(_watchlistMovies.execute());
        return const OnFetchMovieWatchlist().props;
      },
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'should emit Loading state and then HasData state when data unsuccessfully fetched',
      build: () {
        when(_watchlistMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(const OnFetchMovieWatchlist()),
      expect: () => [
        WatchlistLoading(),
        const WatchlistError('Server Failure'),
      ],
      verify: (bloc) {
        WatchlistLoading();
      },
    );
  });

  group('OnWatchlistMovieStatus', () {
    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'should emit Loading state and then HasData state when data successfully fetched',
      build: () {
        when(_status.execute(testId)).thenAnswer((_) async => true);
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(const OnWatchlistMovieStatus(testId)),
      expect: () => [
        WatchlistState(true),
      ],
      verify: (bloc) {
        verify(_status.execute(testId));
        return const OnWatchlistMovieStatus(testId).props;
      },
    );
  });

  group('OnAddWatchlistMovie', () {
    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'should emit Loading state and then HasData state when data successfully fetched',
      build: () {
        when(_saveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right(watchlistAddSuccessMessage));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(OnAddWatchlistMovie(testMovieDetail)),
      expect: () => [
        WatchlistState(true),
      ],
      verify: (bloc) {
        verify(_saveWatchlist.execute(testMovieDetail));
        return OnAddWatchlistMovie(testMovieDetail).props;
      },
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'should emit Loading state and then HasData state when data unsuccessfully fetched',
      build: () {
        when(_saveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(OnAddWatchlistMovie(testMovieDetail)),
      expect: () => [
        const WatchlistError('Server Failure'),
      ],
      verify: (bloc) {
        WatchlistLoading();
      },
    );
  });

  group('OnRemoveWatchlistMovie', () {
    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'should emit Loading state and then HasData state when data successfully fetched',
      build: () {
        when(_removeWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right(watchlistRemoveSuccessMessage));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(OnRemoveWatchlistMovie(testMovieDetail)),
      expect: () => [
        WatchlistState(false),
      ],
      verify: (bloc) {
        verify(_removeWatchlist.execute(testMovieDetail));
        return OnRemoveWatchlistMovie(testMovieDetail).props;
      },
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'should emit Loading state and then HasData state when data unsuccessfully fetched',
      build: () {
        when(_removeWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(OnRemoveWatchlistMovie(testMovieDetail)),
      expect: () => [
        const WatchlistError('Server Failure'),
      ],
      verify: (bloc) {
        WatchlistLoading();
      },
    );
  });
}
