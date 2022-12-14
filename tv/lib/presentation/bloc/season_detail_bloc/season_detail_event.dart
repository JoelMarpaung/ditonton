import 'package:equatable/equatable.dart';

abstract class SeasonDetailEvent extends Equatable {
  const SeasonDetailEvent();
}

class OnFetchSeasonDetail extends SeasonDetailEvent {
  final int id;
  final int seasonNumber;
  const OnFetchSeasonDetail(this.id, this.seasonNumber);

  @override
  List<Object> get props => [];
}
