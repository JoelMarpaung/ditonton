import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_movie_detail.dart';
import '../../../domain/usecases/get_movie_recommendations.dart';
import '../../../domain/usecases/get_watchlist_status.dart';
import 'movie_detail_event.dart';
import 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _detailMovies;
  final GetMovieRecommendations _recommendations;
  final GetWatchListStatus _status;

  MovieDetailBloc(this._detailMovies, this._recommendations, this._status)
      : super(DetailEmpty()) {
    on<OnFetchMovieDetail>((event, emit) async {
      final id = event.id;

      emit(DetailLoading());
      final result = await _detailMovies.execute(id);
      final recommend = await _recommendations.execute(id);
      final status = await _status.execute(id);
      result.fold(
        (failure) {
          emit(DetailError(failure.message));
        },
        (detail) {
          recommend.fold(
            (failure) {
              emit(DetailError(failure.message));
            },
            (rec) {
              emit(DetailHasData(detail, rec, status));
            },
          );
        },
      );
    });
  }
}
