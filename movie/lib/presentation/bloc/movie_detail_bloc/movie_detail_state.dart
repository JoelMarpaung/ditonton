import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie_detail.dart';

import '../../../domain/entities/movie.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class DetailEmpty extends MovieDetailState {}

class DetailLoading extends MovieDetailState {}

class DetailError extends MovieDetailState {
  final String message;

  const DetailError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailHasData extends MovieDetailState {
  final MovieDetail result;
  final List<Movie> recommend;
  final bool watchlist;

  const DetailHasData(this.result, this.recommend, this.watchlist);

  @override
  List<Object> get props => [result, recommend, watchlist];
}
