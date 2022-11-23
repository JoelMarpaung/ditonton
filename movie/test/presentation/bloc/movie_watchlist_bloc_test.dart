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
  late MockGetWatchlistMovies watchlistMovies;
  late MockGetWatchListStatus status;
  late MockSaveWatchlist saveWatchlist;
  late MockRemoveWatchlist removeWatchlist;
  late MovieWatchlistBloc movieWatchlistBloc;

  const testId = 1;

  setUp(() {
    watchlistMovies = MockGetWatchlistMovies();
    status = MockGetWatchListStatus();
    saveWatchlist = MockSaveWatchlist();
    removeWatchlist = MockRemoveWatchlist();
    movieWatchlistBloc = MovieWatchlistBloc(
        watchlistMovies, saveWatchlist, removeWatchlist, status);
  });

  test('the initial state should be empty', () {
    expect(movieWatchlistBloc.state, WatchlistEmpty());
  });

  group('OnFetchMovieWatchlist', () {
    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'should emit Loading state and then HasData state when data successfully fetched',
      build: () {
        when(watchlistMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(const OnFetchMovieWatchlist()),
      expect: () => [
        WatchlistLoading(),
        WatchlistHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(watchlistMovies.execute());
        return const OnFetchMovieWatchlist().props;
      },
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'should emit Loading state and then HasData state when data unsuccessfully fetched',
      build: () {
        when(watchlistMovies.execute()).thenAnswer(
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
        when(status.execute(testId)).thenAnswer((_) async => true);
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(const OnWatchlistMovieStatus(testId)),
      expect: () => [
        WatchlistState(true),
      ],
      verify: (bloc) {
        verify(status.execute(testId));
        return const OnWatchlistMovieStatus(testId).props;
      },
    );
  });

  group('OnAddWatchlistMovie', () {
    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'should emit Loading state and then HasData state when data successfully fetched',
      build: () {
        when(saveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right(watchlistAddSuccessMessage));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(const OnAddWatchlistMovie(testMovieDetail)),
      expect: () => [
        WatchlistState(true),
      ],
      verify: (bloc) {
        verify(saveWatchlist.execute(testMovieDetail));
        return const OnAddWatchlistMovie(testMovieDetail).props;
      },
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'should emit Loading state and then HasData state when data unsuccessfully fetched',
      build: () {
        when(saveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(const OnAddWatchlistMovie(testMovieDetail)),
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
        when(removeWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => const Right(watchlistRemoveSuccessMessage));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(const OnRemoveWatchlistMovie(testMovieDetail)),
      expect: () => [
        WatchlistState(false),
      ],
      verify: (bloc) {
        verify(removeWatchlist.execute(testMovieDetail));
        return const OnRemoveWatchlistMovie(testMovieDetail).props;
      },
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'should emit Loading state and then HasData state when data unsuccessfully fetched',
      build: () {
        when(removeWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(const OnRemoveWatchlistMovie(testMovieDetail)),
      expect: () => [
        const WatchlistError('Server Failure'),
      ],
      verify: (bloc) {
        WatchlistLoading();
      },
    );
  });
}
