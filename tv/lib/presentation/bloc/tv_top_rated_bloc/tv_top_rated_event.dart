import 'package:equatable/equatable.dart';

abstract class TvTopRatedEvent extends Equatable {
  const TvTopRatedEvent();
}

class OnFetchTvTopRated extends TvTopRatedEvent {
  const OnFetchTvTopRated();

  @override
  List<Object> get props => [];
}
