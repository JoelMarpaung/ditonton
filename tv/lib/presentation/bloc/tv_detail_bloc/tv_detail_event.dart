import 'package:equatable/equatable.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();

  @override
  List<Object> get props => [];
}

class OnFetchTvDetail extends TvDetailEvent {
  final int id;
  OnFetchTvDetail(this.id);

  @override
  List<Object> get props => [];
}

