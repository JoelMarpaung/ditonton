import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail_bloc/movie_detail_event.dart';
import 'package:movie/presentation/bloc/movie_detail_bloc/movie_detail_state.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/bloc_helper_test.mocks.dart';

void main() {
  late MockGetMovieDetail _detailMovies;
  late MockGetMovieRecommendations _recommendations;
  late MockGetWatchListStatus _status;
  late MovieDetailBloc movieDetailBloc;

  const testId = 1;

  setUp(() {
    _detailMovies = MockGetMovieDetail();
    _recommendations = MockGetMovieRecommendations();
    _status = MockGetWatchListStatus();
    movieDetailBloc = MovieDetailBloc(_detailMovies, _recommendations, _status);
  });

  test('the initial state should be empty', () {
    expect(movieDetailBloc.state, DetailEmpty());
  });

  blocTest<MovieDetailBloc, MovieDetailState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(_detailMovies.execute(testId))
          .thenAnswer((_) async => Right(testMovieDetail));
      when(_recommendations.execute(testId))
          .thenAnswer((_) async => Right(testMovieList));
      when(_status.execute(testId))
          .thenAnswer((_) async => true);
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(const OnFetchMovieDetail(testId)),
    expect: () => [
      DetailLoading(),
      DetailHasData(testMovieDetail, testMovieList, true),
    ],
    verify: (bloc) {
      verify(_detailMovies.execute(testId));
      verify(_recommendations.execute(testId));
      verify(_status.execute(testId));
      return const OnFetchMovieDetail(testId).props;
    },
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'should emit Loading state and then HasData state when data unsuccessfully fetched',
    build: () {
      when(_detailMovies.execute(testId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      when(_recommendations.execute(testId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      when(_status.execute(testId))
          .thenAnswer((_) async => false);
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(const OnFetchMovieDetail(testId)),
    expect: () => [
      DetailLoading(),
      const DetailError('Server Failure'),
    ],
    verify: (bloc) {
      DetailLoading();
    },
  );
}
