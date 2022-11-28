import 'package:equatable/equatable.dart';

abstract class TvNowPlayingEvent extends Equatable {
  const TvNowPlayingEvent();
}

class OnFetchTvNowPlaying extends TvNowPlayingEvent {
  const OnFetchTvNowPlaying();

  @override
  List<Object> get props => [];
}
