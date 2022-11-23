import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/movie_top_rated_bloc/movie_top_rated_bloc.dart';
import 'package:movie/presentation/bloc/movie_top_rated_bloc/movie_top_rated_event.dart';
import 'package:movie/presentation/bloc/movie_top_rated_bloc/movie_top_rated_state.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/bloc_helper_test.mocks.dart';

void main() {
  late MockGetTopRatedMovies topRatedMovies;
  late MovieTopRatedBloc movieTopRatedBloc;

  setUp(() {
    topRatedMovies = MockGetTopRatedMovies();
    movieTopRatedBloc = MovieTopRatedBloc(topRatedMovies);
  });

  test('the initial state should be empty', () {
    expect(movieTopRatedBloc.state, TopRatedEmpty());
  });

  blocTest<MovieTopRatedBloc, MovieTopRatedState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(topRatedMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return movieTopRatedBloc;
    },
    act: (bloc) => bloc.add(const OnFetchMovieTopRated()),
    expect: () => [
      TopRatedLoading(),
      TopRatedHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(topRatedMovies.execute());
      return const OnFetchMovieTopRated().props;
    },
  );

  blocTest<MovieTopRatedBloc, MovieTopRatedState>(
    'should emit Loading state and then HasData state when data unsuccessfully fetched',
    build: () {
      when(topRatedMovies.execute())
          .thenAnswer((_) async =>const Left(ServerFailure('Server Failure')));
      return movieTopRatedBloc;
    },
    act: (bloc) => bloc.add(const OnFetchMovieTopRated()),
    expect: () => [
      TopRatedLoading(),
      const TopRatedError('Server Failure'),
    ],
    verify: (bloc) {
      TopRatedLoading();
    },
  );
}
