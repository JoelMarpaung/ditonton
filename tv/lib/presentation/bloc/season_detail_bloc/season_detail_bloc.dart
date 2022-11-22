import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_season_detail.dart';
import 'season_detail_event.dart';
import 'season_detail_state.dart';

class SeasonDetailBloc extends Bloc<SeasonDetailEvent, SeasonDetailState> {
  final GetSeasonDetail _detailSeasons;

  SeasonDetailBloc(this._detailSeasons) : super(DetailEmpty()) {
    on<OnFetchSeasonDetail>((event, emit) async {
      final id = event.id;
      final seasonNumber = event.seasonNumber;

      emit(DetailLoading());
      final result = await _detailSeasons.execute(id, seasonNumber);
      result.fold(
        (failure) {
          emit(DetailError(failure.message));
        },
        (detail) {
          emit(DetailHasData(detail));
        },
      );
    });
  }
}
