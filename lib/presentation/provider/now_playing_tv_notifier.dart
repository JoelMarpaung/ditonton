import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv.dart';
import 'package:flutter/foundation.dart';

class NowPlayingTvsNotifier extends ChangeNotifier {
  final GetNowPlayingTvs getNowPlayingTvs;

  NowPlayingTvsNotifier(this.getNowPlayingTvs);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _Tvs = [];
  List<Tv> get Tvs => _Tvs;

  String _message = '';
  String get message => _message;

  Future<void> fetchNowPlayingTvs() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTvs.execute();

    result.fold(
          (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
          (TvsData) {
        _Tvs = TvsData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
