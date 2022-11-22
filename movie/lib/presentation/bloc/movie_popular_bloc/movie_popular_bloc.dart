import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_popular_movies.dart';
import 'movie_popular_event.dart';
import 'movie_popular_state.dart';


class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  final GetPopularMovies _popularMovies;

  MoviePopularBloc(this._popularMovies) : super(PopularEmpty()) {
    on<OnFetchMoviePopular>((event, emit) async {

      emit(PopularLoading());
      final result = await _popularMovies.execute();

      result.fold(
            (failure) {
          emit(PopularError(failure.message));
        },
            (data) {
          emit(PopularHasData(data));
        },
      );
    });
  }
}
