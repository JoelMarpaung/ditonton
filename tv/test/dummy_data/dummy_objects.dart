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
    genreIds: const [],
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
    genres: const [],
    seasons: const []);

const testSeasonDetail = SeasonDetail(
    posterPath: '',
    id: 0,
    overview: '',
    name: '',
    seasonNumber: 1,
    episodes: []);

final testWatchListTv =
    Tv.watchlist(id: 0, overview: '', posterPath: '', name: '');

const testTvTable = TvTable(
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
