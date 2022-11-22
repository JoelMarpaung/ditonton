import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/constants.dart';
import 'package:core/route/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/presentation/bloc/movie_now_playing_bloc/movie_now_playing_event.dart';
import 'package:movie/presentation/bloc/movie_now_playing_bloc/movie_now_playing_state.dart';
import 'package:core/custom_widget/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:movie/presentation/bloc/movie_popular_bloc/movie_popular_event.dart';
import 'package:movie/presentation/bloc/movie_top_rated_bloc/movie_top_rated_event.dart';

import '../bloc/movie_now_playing_bloc/movie_now_playing_bloc.dart';
import '../bloc/movie_popular_bloc/movie_popular_bloc.dart';
import '../bloc/movie_popular_bloc/movie_popular_state.dart';
import '../bloc/movie_top_rated_bloc/movie_top_rated_bloc.dart';
import '../bloc/movie_top_rated_bloc/movie_top_rated_state.dart';

class HomeMoviePage extends StatefulWidget {
  static const ROUTE_NAME = '/home';
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<MovieNowPlayingBloc>().add(OnFetchMovieNowPlaying());
    context.read<MoviePopularBloc>().add(OnFetchMoviePopular());
    context.read<MovieTopRatedBloc>().add(OnFetchMovieTopRated());
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Ditonton Movies'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, searchPage);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<MovieNowPlayingBloc, MovieNowPlayingState>(
                builder: (context, state) {
                  if (state is NowPlayingLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NowPlayingHasData) {
                    return MovieList(state.result);
                  } else if (state is NowPlayingError) {
                    return Expanded(
                      child: Center(
                        child: Text(state.message),
                      ),
                    );
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(context, popularMoviePage),
              ),
              BlocBuilder<MoviePopularBloc, MoviePopularState>(
                builder: (context, state) {
                  if (state is PopularLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularHasData) {
                    return MovieList(state.result);
                  } else if (state is PopularError) {
                    return Expanded(
                      child: Center(
                        child: Text(state.message),
                      ),
                    );
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(context, topRatedMoviePage),
              ),
              BlocBuilder<MovieTopRatedBloc, MovieTopRatedState>(
                builder: (context, state) {
                  if (state is TopRatedLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedHasData) {
                    return MovieList(state.result);
                  } else if (state is TopRatedError) {
                    return Expanded(
                      child: Center(
                        child: Text(state.message),
                      ),
                    );
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  movieDetailPage,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
