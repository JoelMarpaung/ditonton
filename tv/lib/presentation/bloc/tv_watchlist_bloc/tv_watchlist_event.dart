import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv_detail.dart';

abstract class TvWatchlistEvent extends Equatable {
  const TvWatchlistEvent();
}

class OnFetchTvWatchlist extends TvWatchlistEvent {
  const OnFetchTvWatchlist();

  @override
  List<Object> get props => [];
}

class OnAddWatchlistTv extends TvWatchlistEvent {
  final TvDetail tvDetail;

  const OnAddWatchlistTv(this.tvDetail);

  @override
  List<Object> get props => [];
}

class OnRemoveWatchlistTv extends TvWatchlistEvent {
  final TvDetail tvDetail;

  const OnRemoveWatchlistTv(this.tvDetail);

  @override
  List<Object> get props => [];
}

class OnWatchlistTvStatus extends TvWatchlistEvent {
  final int id;

  const OnWatchlistTvStatus(this.id);

  @override
  List<Object> get props => [];
}
