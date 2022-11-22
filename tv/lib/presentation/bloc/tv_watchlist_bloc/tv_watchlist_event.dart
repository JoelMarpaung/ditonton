import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv_detail.dart';

abstract class TvWatchlistEvent extends Equatable {
  const TvWatchlistEvent();

  @override
  List<Object> get props => [];
}

class OnFetchTvWatchlist extends TvWatchlistEvent {
  OnFetchTvWatchlist();

  @override
  List<Object> get props => [];
}

class OnAddWatchlistTv extends TvWatchlistEvent {
  final TvDetail tvDetail;

  OnAddWatchlistTv(this.tvDetail);

  @override
  List<Object> get props => [];
}

class OnRemoveWatchlistTv extends TvWatchlistEvent {
  final TvDetail tvDetail;

  OnRemoveWatchlistTv(this.tvDetail);

  @override
  List<Object> get props => [];
}

class OnWatchlistTvStatus extends TvWatchlistEvent {
  final int id;

  OnWatchlistTvStatus(this.id);

  @override
  List<Object> get props => [];
}