import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv.dart';

abstract class TvTopRatedState extends Equatable {
  const TvTopRatedState();

  @override
  List<Object> get props => [];
}

class TopRatedEmpty extends TvTopRatedState {}

class TopRatedLoading extends TvTopRatedState {}

class TopRatedError extends TvTopRatedState {
  final String message;

  const TopRatedError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedHasData extends TvTopRatedState {
  final List<Tv> result;

  const TopRatedHasData(this.result);

  @override
  List<Object> get props => [result];
}
