import 'package:equatable/equatable.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class OnFetchMovieDetail extends MovieDetailEvent {
  final int id;
  const OnFetchMovieDetail(this.id);

  @override
  List<Object> get props => [];
}
