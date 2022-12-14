import 'package:equatable/equatable.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();
}

class OnFetchTvDetail extends TvDetailEvent {
  final int id;
  const OnFetchTvDetail(this.id);

  @override
  List<Object> get props => [];
}
