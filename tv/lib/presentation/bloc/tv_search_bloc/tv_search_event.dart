import 'package:equatable/equatable.dart';

abstract class TvSearchEvent extends Equatable {
  const TvSearchEvent();
}

class OnQueryChanged extends TvSearchEvent {
  final String query;

  const OnQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}
