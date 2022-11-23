

import 'package:movie/data/models/movie_table.dart';
import 'package:tv/data/models/tv_table.dart';
import 'package:tv/domain/entities/season_detail.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';



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

final statusTv = Future<bool>.value(true);

final testTvList = [testTv];



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


final testTvMap = {
  'id': 0,
  'overview': '',
  'posterPath': '',
  'name': '',
};
