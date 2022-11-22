import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/season_detail.dart';

import '../../../domain/entities/Season.dart';
import '../../../domain/entities/episode.dart';

abstract class SeasonDetailState extends Equatable {
  const SeasonDetailState();

  @override
  List<Object> get props => [];
}

class DetailEmpty extends SeasonDetailState {}

class DetailLoading extends SeasonDetailState {}

class DetailError extends SeasonDetailState {
  final String message;

  DetailError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailHasData extends SeasonDetailState {
  final SeasonDetail result;

  DetailHasData(this.result);

  @override
  List<Object> get props => [result];
}
