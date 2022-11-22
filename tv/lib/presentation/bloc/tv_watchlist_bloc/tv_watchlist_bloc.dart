import 'package:core/common/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_watchlist_tv.dart';
import '../../../domain/usecases/get_watchlist_status_tv.dart';
import '../../../domain/usecases/remove_watchlist_tv.dart';
import '../../../domain/usecases/save_watchlist_tv.dart';
import 'tv_watchlist_event.dart';
import 'tv_watchlist_state.dart';

class TvWatchlistBloc extends Bloc<TvWatchlistEvent, TvWatchlistState> {
  String message = '';
  bool status = false;
  final GetWatchlistTvs _watchlistTvs;
  final GetWatchListStatusTv _status;
  final SaveWatchlistTv _saveWatchlist;
  final RemoveWatchlistTv _removeWatchlist;

  TvWatchlistBloc(this._watchlistTvs, this._saveWatchlist,
      this._removeWatchlist, this._status)
      : super(WatchlistEmpty()) {
    on<OnFetchTvWatchlist>((event, emit) async {
      emit(WatchlistLoading());
      final result = await _watchlistTvs.execute();

      result.fold(
        (failure) {
          emit(WatchlistError(failure.message));
        },
        (data) {
          emit(WatchlistHasData(data));
        },
      );
    });

    on<OnWatchlistTvStatus>((event, emit) async {
      final id = event.id;
      final result = await _status.execute(id);
      status = result;
      emit(WatchlistState(result));
    });

    on<OnAddWatchlistTv>((event, emit) async {
      final tv = event.tvDetail;
      final result = await _saveWatchlist.execute(tv);
      result.fold((failure) {
        emit(WatchlistError(failure.message));
      }, (data) {
        //emit(WatchlistSuccess(data));
        emit(WatchlistState(true));
        status = true;
        message = watchlistAddSuccessMessage;
      });
    });

    on<OnRemoveWatchlistTv>((event, emit) async {
      final tv = event.tvDetail;
      final result = await _removeWatchlist.execute(tv);
      result.fold((failure) {
        emit(WatchlistError(failure.message));
      }, (data) {
        //emit(WatchlistSuccess(data));
        emit(WatchlistState(false));
        status = false;
        message = watchlistRemoveSuccessMessage;
      });
    });
  }
}
