import 'package:equatable/equatable.dart';

abstract class MoviePopularEvent extends Equatable {
  const MoviePopularEvent();
}

class OnFetchMoviePopular extends MoviePopularEvent {
  const OnFetchMoviePopular();

  @override
  List<Object> get props => [];
}
