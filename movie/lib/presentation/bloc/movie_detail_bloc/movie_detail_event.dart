import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie_detail.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class OnFetchMovieDetail extends MovieDetailEvent {
  final int id;
  OnFetchMovieDetail(this.id);

  @override
  List<Object> get props => [];
}

