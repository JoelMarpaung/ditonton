import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';

abstract class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();

  @override
  List<Object> get props => [];
}

class WatchlistEmpty extends MovieWatchlistState {}

class WatchlistLoading extends MovieWatchlistState {}

class WatchlistError extends MovieWatchlistState {
  final String message;

  WatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistHasData extends MovieWatchlistState {
  final List<Movie> result;

  WatchlistHasData(this.result);

  @override
  List<Object> get props => [result];
}

class WatchlistSuccess extends MovieWatchlistState {
  final String message;

  WatchlistSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistState extends MovieWatchlistState {
  bool isAddedToWatchlist = false;

  WatchlistState(this.isAddedToWatchlist);

  @override
  List<Object> get props => [isAddedToWatchlist];
}