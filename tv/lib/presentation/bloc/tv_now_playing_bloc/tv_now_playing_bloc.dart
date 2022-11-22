import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/tv_now_playing_bloc/tv_now_playing_event.dart';
import 'package:tv/presentation/bloc/tv_now_playing_bloc/tv_now_playing_state.dart';

import '../../../domain/usecases/get_now_playing_tv.dart';

class TvNowPlayingBloc extends Bloc<TvNowPlayingEvent, TvNowPlayingState> {
  final GetNowPlayingTvs _nowPlayingTvs;

  TvNowPlayingBloc(this._nowPlayingTvs) : super(NowPlayingEmpty()) {
    on<OnFetchTvNowPlaying>((event, emit) async {
      emit(NowPlayingLoading());
      final result = await _nowPlayingTvs.execute();

      result.fold(
        (failure) {
          emit(NowPlayingError(failure.message));
        },
        (data) {
          emit(NowPlayingHasData(data));
        },
      );
    });
  }
}
