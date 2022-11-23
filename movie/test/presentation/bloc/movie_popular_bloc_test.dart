import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/movie_popular_bloc/movie_popular_bloc.dart';
import 'package:movie/presentation/bloc/movie_popular_bloc/movie_popular_event.dart';
import 'package:movie/presentation/bloc/movie_popular_bloc/movie_popular_state.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/bloc_helper_test.mocks.dart';

void main() {
  late MockGetPopularMovies _popularMovies;
  late MoviePopularBloc moviePopularBloc;

  setUp(() {
    _popularMovies = MockGetPopularMovies();
    moviePopularBloc = MoviePopularBloc(_popularMovies);
  });

  test('the initial state should be empty', () {
    expect(moviePopularBloc.state, PopularEmpty());
  });

  blocTest<MoviePopularBloc, MoviePopularState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(_popularMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return moviePopularBloc;
    },
    act: (bloc) => bloc.add(const OnFetchMoviePopular()),
    expect: () => [
      PopularLoading(),
      PopularHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(_popularMovies.execute());
      return const OnFetchMoviePopular().props;
    },
  );

  blocTest<MoviePopularBloc, MoviePopularState>(
    'should emit Loading state and then HasData state when data unsuccessfully fetched',
    build: () {
      when(_popularMovies.execute())
          .thenAnswer((_) async =>const Left(ServerFailure('Server Failure')));
      return moviePopularBloc;
    },
    act: (bloc) => bloc.add(const OnFetchMoviePopular()),
    expect: () => [
      PopularLoading(),
      const PopularError('Server Failure'),
    ],
    verify: (bloc) {
      PopularLoading();
    },
  );
}
