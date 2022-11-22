import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';

abstract class MoviePopularState extends Equatable {
  const MoviePopularState();

  @override
  List<Object> get props => [];
}

class PopularEmpty extends MoviePopularState {}

class PopularLoading extends MoviePopularState {}

class PopularError extends MoviePopularState {
  final String message;

  const PopularError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularHasData extends MoviePopularState {
  final List<Movie> result;

  const PopularHasData(this.result);

  @override
  List<Object> get props => [result];
}
