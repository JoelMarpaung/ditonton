import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/season_detail.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testTv = Tv(
    posterPath: '',
    popularity: 0,
    id: 0,
    backdropPath: '',
    voteAverage: 0,
    overview: '',
    genreIds: [],
    originalLanguage: '',
    voteCount: 0,
    name: '',
    originalName: '');

final testMovieList = [testMovie];

final testTvList = [testTv];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testTvDetail = TvDetail(
    posterPath: '',
    popularity: 0,
    id: 0,
    backdropPath: '',
    voteAverage: 0,
    overview: '',
    originalLanguage: '',
    voteCount: 0,
    name: '',
    originalName: '',
    genres: [],
    seasons: []);

final testSeasonDetail = SeasonDetail(
    posterPath: '',
    id: 0,
    overview: '',
    name: '', seasonNumber: 1, episodes: []);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testWatchListTv =
    Tv.watchlist(id: 0, overview: '', posterPath: '', name: '');

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvTable = TvTable(
  id: 0,
  name: '',
  posterPath: '',
  overview: '',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTvMap = {
  'id': 0,
  'overview': '',
  'posterPath': '',
  'name': '',
};
