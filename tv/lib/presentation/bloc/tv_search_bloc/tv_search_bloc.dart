import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/tv_search_bloc/tv_search_event.dart';
import 'package:tv/presentation/bloc/tv_search_bloc/tv_search_state.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/usecases/search_tv.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTvs _searchTvs;

  TvSearchBloc(this._searchTvs) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final result = await _searchTvs.execute(query);

      result.fold(
        (failure) {
          emit(SearchError(failure.message));
        },
        (data) {
          emit(SearchHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
