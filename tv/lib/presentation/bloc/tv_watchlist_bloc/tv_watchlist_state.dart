import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv.dart';

abstract class TvWatchlistState extends Equatable {
  const TvWatchlistState();

  @override
  List<Object> get props => [];
}

class WatchlistEmpty extends TvWatchlistState {}

class WatchlistLoading extends TvWatchlistState {}

class WatchlistError extends TvWatchlistState {
  final String message;

  const WatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistHasData extends TvWatchlistState {
  final List<Tv> result;

  const WatchlistHasData(this.result);

  @override
  List<Object> get props => [result];
}

class WatchlistSuccess extends TvWatchlistState {
  final String message;

  const WatchlistSuccess(this.message);

  @override
  List<Object> get props => [message];
}

// ignore: must_be_immutable
class WatchlistState extends TvWatchlistState {
  bool isAddedToWatchlist = false;

  WatchlistState(this.isAddedToWatchlist);

  @override
  List<Object> get props => [isAddedToWatchlist];
}
