import 'package:equatable/equatable.dart';

abstract class TvTopRatedEvent extends Equatable {
  const TvTopRatedEvent();

  @override
  List<Object> get props => [];
}

class OnFetchTvTopRated extends TvTopRatedEvent {
  const OnFetchTvTopRated();

  @override
  List<Object> get props => [];
}
