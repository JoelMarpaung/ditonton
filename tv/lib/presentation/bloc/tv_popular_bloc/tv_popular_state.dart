import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv.dart';

abstract class TvPopularState extends Equatable {
  const TvPopularState();

  @override
  List<Object> get props => [];
}

class PopularEmpty extends TvPopularState {}

class PopularLoading extends TvPopularState {}

class PopularError extends TvPopularState {
  final String message;

  PopularError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularHasData extends TvPopularState {
  final List<Tv> result;

  PopularHasData(this.result);

  @override
  List<Object> get props => [result];
}