import 'package:equatable/equatable.dart';

abstract class TvPopularEvent extends Equatable {
  const TvPopularEvent();
}

class OnFetchTvPopular extends TvPopularEvent {
  const OnFetchTvPopular();

  @override
  List<Object> get props => [];
}
