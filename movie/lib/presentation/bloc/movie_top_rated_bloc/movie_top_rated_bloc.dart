import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_top_rated_movies.dart';
import 'movie_top_rated_event.dart';
import 'movie_top_rated_state.dart';

class MovieTopRatedBloc extends Bloc<MovieTopRatedEvent, MovieTopRatedState> {
  final GetTopRatedMovies _topRatedMovies;

  MovieTopRatedBloc(this._topRatedMovies) : super(TopRatedEmpty()) {
    on<OnFetchMovieTopRated>((event, emit) async {
      emit(TopRatedLoading());
      final result = await _topRatedMovies.execute();

      result.fold(
        (failure) {
          emit(TopRatedError(failure.message));
        },
        (data) {
          emit(TopRatedHasData(data));
        },
      );
    });
  }
}
