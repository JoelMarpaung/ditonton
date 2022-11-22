import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_popular_tv.dart';
import 'tv_popular_event.dart';
import 'tv_popular_state.dart';

class TvPopularBloc extends Bloc<TvPopularEvent, TvPopularState> {
  final GetPopularTvs _popularTvs;

  TvPopularBloc(this._popularTvs) : super(PopularEmpty()) {
    on<OnFetchTvPopular>((event, emit) async {
      emit(PopularLoading());
      final result = await _popularTvs.execute();

      result.fold(
        (failure) {
          emit(PopularError(failure.message));
        },
        (data) {
          emit(PopularHasData(data));
        },
      );
    });
  }
}
