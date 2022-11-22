import 'package:equatable/equatable.dart';

abstract class MovieTopRatedEvent extends Equatable {
  const MovieTopRatedEvent();

  @override
  List<Object> get props => [];
}

class OnFetchMovieTopRated extends MovieTopRatedEvent {
  OnFetchMovieTopRated();

  @override
  List<Object> get props => [];
}