import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_top_rated_tv.dart';
import 'tv_top_rated_event.dart';
import 'tv_top_rated_state.dart';


class TvTopRatedBloc extends Bloc<TvTopRatedEvent, TvTopRatedState> {
  final GetTopRatedTvs _topRatedTvs;

  TvTopRatedBloc(this._topRatedTvs) : super(TopRatedEmpty()) {
    on<OnFetchTvTopRated>((event, emit) async {

      emit(TopRatedLoading());
      final result = await _topRatedTvs.execute();

      result.fold(
            (failure) {
          emit(TopRatedError(failure.message));
        },
            (data) {
          emit(TopRatedHasData(data));
        },
      );
    });
  }
}
