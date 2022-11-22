import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';

abstract class MovieTopRatedState extends Equatable {
  const MovieTopRatedState();

  @override
  List<Object> get props => [];
}

class TopRatedEmpty extends MovieTopRatedState {}

class TopRatedLoading extends MovieTopRatedState {}

class TopRatedError extends MovieTopRatedState {
  final String message;

  const TopRatedError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedHasData extends MovieTopRatedState {
  final List<Movie> result;

  const TopRatedHasData(this.result);

  @override
  List<Object> get props => [result];
}
