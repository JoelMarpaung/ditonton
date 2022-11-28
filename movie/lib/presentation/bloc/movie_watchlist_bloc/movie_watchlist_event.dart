import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie_detail.dart';

abstract class MovieWatchlistEvent extends Equatable {
  const MovieWatchlistEvent();
}

class OnFetchMovieWatchlist extends MovieWatchlistEvent {
  const OnFetchMovieWatchlist();

  @override
  List<Object> get props => [];
}

class OnAddWatchlistMovie extends MovieWatchlistEvent {
  final MovieDetail movieDetail;

  const OnAddWatchlistMovie(this.movieDetail);

  @override
  List<Object> get props => [];
}

class OnRemoveWatchlistMovie extends MovieWatchlistEvent {
  final MovieDetail movieDetail;

  const OnRemoveWatchlistMovie(this.movieDetail);

  @override
  List<Object> get props => [];
}

class OnWatchlistMovieStatus extends MovieWatchlistEvent {
  final int id;

  const OnWatchlistMovieStatus(this.id);

  @override
  List<Object> get props => [];
}
