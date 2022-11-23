import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/movie_search_bloc/movie_search_bloc.dart';
import 'package:movie/presentation/bloc/movie_search_bloc/movie_search_event.dart';
import 'package:movie/presentation/bloc/movie_search_bloc/movie_search_state.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/bloc_helper_test.mocks.dart';

void main() {
  late MockSearchMovies searchMovies;
  late MovieSearchBloc movieSearchBloc;

  const testQuery = 'game of throne';

  setUp(() {
    searchMovies = MockSearchMovies();
    movieSearchBloc = MovieSearchBloc(searchMovies);
  });

  test('the initial state should be empty', () {
    expect(movieSearchBloc.state, SearchEmpty());
  });

  blocTest<MovieSearchBloc, MovieSearchState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(searchMovies.execute(testQuery))
          .thenAnswer((_) async => Right(testMovieList));
      return movieSearchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(testQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(searchMovies.execute(testQuery));
      return const OnQueryChanged(testQuery).props;
    },
  );

  blocTest<MovieSearchBloc, MovieSearchState>(
    'should emit Loading state and then HasData state when data unsuccessfully fetched',
    build: () {
      when(searchMovies.execute(testQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return movieSearchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(testQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      const SearchError('Server Failure'),
    ],
    verify: (bloc) {
      SearchLoading();
    },
  );
}
