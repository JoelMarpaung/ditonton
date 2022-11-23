
import 'package:mockito/annotations.dart';
import 'package:tv/domain/usecases/get_now_playing_tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
import 'package:tv/domain/usecases/get_season_detail.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';
import 'package:tv/domain/usecases/get_watchlist_status_tv.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/save_watchlist_tv.dart';
import 'package:tv/domain/usecases/search_tv.dart';

@GenerateMocks([
  GetNowPlayingTvs,
  GetPopularTvs,
  GetSeasonDetail,
  GetTopRatedTvs,
  GetTvDetail,
  GetTvRecommendations,
  GetWatchListStatusTv,
  GetWatchlistTvs,
  RemoveWatchlistTv,
  SaveWatchlistTv,
  SearchTvs
])
void main() {}
