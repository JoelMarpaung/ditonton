import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/movie_now_playing_bloc/movie_now_playing_bloc.dart';
import 'package:movie/presentation/bloc/movie_now_playing_bloc/movie_now_playing_event.dart';
import 'package:movie/presentation/bloc/movie_now_playing_bloc/movie_now_playing_state.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/bloc_helper_test.mocks.dart';

void main() {
  late MockGetNowPlayingMovies nowPlayingMovies;
  late MovieNowPlayingBloc movieNowPlayingBloc;

  setUp(() {
    nowPlayingMovies = MockGetNowPlayingMovies();
    movieNowPlayingBloc = MovieNowPlayingBloc(nowPlayingMovies);
  });

  test('the initial state should be empty', () {
    expect(movieNowPlayingBloc.state, NowPlayingEmpty());
  });

  blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(nowPlayingMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return movieNowPlayingBloc;
    },
    act: (bloc) => bloc.add(const OnFetchMovieNowPlaying()),
    expect: () => [
      NowPlayingLoading(),
      NowPlayingHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(nowPlayingMovies.execute());
      return const OnFetchMovieNowPlaying().props;
    },
  );

  blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
    'should emit Loading state and then HasData state when data unsuccessfully fetched',
    build: () {
      when(nowPlayingMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return movieNowPlayingBloc;
    },
    act: (bloc) => bloc.add(const OnFetchMovieNowPlaying()),
    expect: () => [
      NowPlayingLoading(),
      const NowPlayingError('Server Failure'),
    ],
    verify: (bloc) {
      NowPlayingLoading();
    },
  );
}
