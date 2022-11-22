import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_tv_detail.dart';
import '../../../domain/usecases/get_tv_recommendations.dart';
import '../../../domain/usecases/get_watchlist_status_tv.dart';
import 'tv_detail_event.dart';
import 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail _detailTvs;
  final GetTvRecommendations _recommendations;
  final GetWatchListStatusTv _status;


  TvDetailBloc(this._detailTvs, this._recommendations, this._status)
      : super(DetailEmpty()) {
    on<OnFetchTvDetail>((event, emit) async {
      final id = event.id;

      emit(DetailLoading());
      final result = await _detailTvs.execute(id);
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
