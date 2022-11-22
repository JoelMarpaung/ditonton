import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv_detail.dart';

import '../../../domain/entities/tv.dart';

abstract class TvDetailState extends Equatable {
  const TvDetailState();

  @override
  List<Object> get props => [];
}

class DetailEmpty extends TvDetailState {}

class DetailLoading extends TvDetailState {}

class DetailError extends TvDetailState {
  final String message;

  DetailError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailHasData extends TvDetailState {
  final TvDetail result;
  final List<Tv> recommend;
  final bool watchlist;

  DetailHasData(this.result, this.recommend, this.watchlist);

  @override
  List<Object> get props => [result, recommend, watchlist];
}
