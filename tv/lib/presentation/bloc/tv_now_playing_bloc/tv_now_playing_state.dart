import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv.dart';

abstract class TvNowPlayingState extends Equatable {
  const TvNowPlayingState();

  @override
  List<Object> get props => [];
}

class NowPlayingEmpty extends TvNowPlayingState {}

class NowPlayingLoading extends TvNowPlayingState {}

class NowPlayingError extends TvNowPlayingState {
  final String message;

  NowPlayingError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingHasData extends TvNowPlayingState {
  final List<Tv> result;

  NowPlayingHasData(this.result);

  @override
  List<Object> get props => [result];
}