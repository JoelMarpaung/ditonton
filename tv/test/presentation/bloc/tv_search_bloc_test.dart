import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/tv_search_bloc/tv_search_bloc.dart';
import 'package:tv/presentation/bloc/tv_search_bloc/tv_search_event.dart';
import 'package:tv/presentation/bloc/tv_search_bloc/tv_search_state.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/bloc_helper_test.mocks.dart';

void main() {
  late MockSearchTvs _searchTvs;
  late TvSearchBloc tvSearchBloc;

  const testQuery = 'game of throne';

  setUp(() {
    _searchTvs = MockSearchTvs();
    tvSearchBloc = TvSearchBloc(_searchTvs);
  });

  test('the initial state should be empty', () {
    expect(tvSearchBloc.state, SearchEmpty());
  });

  blocTest<TvSearchBloc, TvSearchState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(_searchTvs.execute(testQuery))
          .thenAnswer((_) async => Right(testTvList));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(testQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchHasData(testTvList),
    ],
    verify: (bloc) {
      verify(_searchTvs.execute(testQuery));
      return const OnQueryChanged(testQuery).props;
    },
  );

  blocTest<TvSearchBloc, TvSearchState>(
    'should emit Loading state and then HasData state when data unsuccessfully fetched',
    build: () {
      when(_searchTvs.execute(testQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvSearchBloc;
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
