import 'package:equatable/equatable.dart';

abstract class MovieTopRatedEvent extends Equatable {
  const MovieTopRatedEvent();
}

class OnFetchMovieTopRated extends MovieTopRatedEvent {
  const OnFetchMovieTopRated();

  @override
  List<Object> get props => [];
}
