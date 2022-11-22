import 'package:core/common/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_watchlist_movies.dart';
import '../../../domain/usecases/get_watchlist_status.dart';
import '../../../domain/usecases/remove_watchlist.dart';
import '../../../domain/usecases/save_watchlist.dart';
import 'movie_watchlist_event.dart';
import 'movie_watchlist_state.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  String message = '';
  bool status = false;
  final GetWatchlistMovies _watchlistMovies;
  final GetWatchListStatus _status;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  MovieWatchlistBloc(this._watchlistMovies, this._saveWatchlist,
      this._removeWatchlist, this._status)
      : super(WatchlistEmpty()) {

    on<OnFetchMovieWatchlist>((event, emit) async {
      emit(WatchlistLoading());
      final result = await _watchlistMovies.execute();

      result.fold(
        (failure) {
          emit(WatchlistError(failure.message));
        },
        (data) {
          emit(WatchlistHasData(data));
        },
      );
    });

    on<OnWatchlistMovieStatus>((event, emit) async {
      final id = event.id;
      final result = await _status.execute(id);
      status = result;
      emit(WatchlistState(result));
    });

    on<OnAddWatchlistMovie>((event, emit) async {
      final movie = event.movieDetail;
      final result = await _saveWatchlist.execute(movie);
      result.fold((failure) {
        emit(WatchlistError(failure.message));
      }, (data) {
        //emit(WatchlistSuccess(data));
        emit(WatchlistState(true));
        status = true;
        message = watchlistAddSuccessMessage;
      });
    });

    on<OnRemoveWatchlistMovie>((event, emit) async {
      final movie = event.movieDetail;
      final result = await _removeWatchlist.execute(movie);
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
