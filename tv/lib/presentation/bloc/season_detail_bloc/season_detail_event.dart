import 'package:equatable/equatable.dart';

abstract class SeasonDetailEvent extends Equatable {
  const SeasonDetailEvent();

  @override
  List<Object> get props => [];
}

class OnFetchSeasonDetail extends SeasonDetailEvent {
  final int id;
  final int seasonNumber;
  OnFetchSeasonDetail(this.id, this.seasonNumber);

  @override
  List<Object> get props => [];
}

