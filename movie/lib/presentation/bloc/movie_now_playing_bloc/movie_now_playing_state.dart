import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';

abstract class MovieNowPlayingState extends Equatable {
  const MovieNowPlayingState();

  @override
  List<Object> get props => [];
}

class NowPlayingEmpty extends MovieNowPlayingState {}

class NowPlayingLoading extends MovieNowPlayingState {}

class NowPlayingError extends MovieNowPlayingState {
  final String message;

  const NowPlayingError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingHasData extends MovieNowPlayingState {
  final List<Movie> result;

  const NowPlayingHasData(this.result);

  @override
  List<Object> get props => [result];
}
