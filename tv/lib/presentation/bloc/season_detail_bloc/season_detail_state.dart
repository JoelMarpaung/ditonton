import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/season_detail.dart';

abstract class SeasonDetailState extends Equatable {
  const SeasonDetailState();

  @override
  List<Object> get props => [];
}

class DetailEmpty extends SeasonDetailState {}

class DetailLoading extends SeasonDetailState {}

class DetailError extends SeasonDetailState {
  final String message;

  const DetailError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailHasData extends SeasonDetailState {
  final SeasonDetail result;

  const DetailHasData(this.result);

  @override
  List<Object> get props => [result];
}
