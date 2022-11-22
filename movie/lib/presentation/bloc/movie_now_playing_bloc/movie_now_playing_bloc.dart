import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie_now_playing_bloc/movie_now_playing_event.dart';
import 'package:movie/presentation/bloc/movie_now_playing_bloc/movie_now_playing_state.dart';

import '../../../domain/usecases/get_now_playing_movies.dart';


class MovieNowPlayingBloc extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState> {
  final GetNowPlayingMovies _nowPlayingMovies;

  MovieNowPlayingBloc(this._nowPlayingMovies) : super(NowPlayingEmpty()) {
    on<OnFetchMovieNowPlaying>((event, emit) async {

      emit(NowPlayingLoading());
      final result = await _nowPlayingMovies.execute();

      result.fold(
            (failure) {
          emit(NowPlayingError(failure.message));
        },
            (data) {
          emit(NowPlayingHasData(data));
        },
      );
    });
  }
}
