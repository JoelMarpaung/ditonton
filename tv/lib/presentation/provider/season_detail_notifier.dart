import 'package:tv/domain/entities/season_detail.dart';
import 'package:tv/domain/usecases/get_season_detail.dart';
import 'package:core/common/state_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SeasonDetailNotifier extends ChangeNotifier {
  final GetSeasonDetail getSeasonDetail;

  SeasonDetailNotifier({
    required this.getSeasonDetail,
  });

  late SeasonDetail _season;
  SeasonDetail get season => _season;

  RequestState _seasonState = RequestState.Empty;
  RequestState get seasonState => _seasonState;

  String _message = '';
  String get message => _message;

  Future<void> fetchSeasonDetail(int id, int seasonNumber) async {
    _seasonState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getSeasonDetail.execute(id, seasonNumber);
    detailResult.fold(
      (failure) {
        _seasonState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (season) {
        _season = season;
        _seasonState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
