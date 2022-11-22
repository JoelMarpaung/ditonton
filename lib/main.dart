import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie_now_playing_bloc/movie_now_playing_bloc.dart';
import 'package:movie/presentation/bloc/movie_popular_bloc/movie_popular_bloc.dart';
import 'package:movie/presentation/bloc/movie_search_bloc/movie_search_bloc.dart';
import 'package:movie/presentation/bloc/movie_top_rated_bloc/movie_top_rated_bloc.dart';
import 'package:movie/presentation/bloc/movie_watchlist_bloc/movie_watchlist_bloc.dart';
import 'package:provider/provider.dart';

import 'package:ditonton/injection.dart' as di;

import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/search_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:movie/presentation/pages/watchlist_movies_page.dart';
import 'package:tv/presentation/bloc/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:tv/presentation/bloc/tv_now_playing_bloc/tv_now_playing_bloc.dart';
import 'package:tv/presentation/bloc/tv_popular_bloc/tv_popular_bloc.dart';
import 'package:tv/presentation/bloc/tv_search_bloc/tv_search_bloc.dart';
import 'package:tv/presentation/bloc/tv_top_rated_bloc/tv_top_rated_bloc.dart';
import 'package:tv/presentation/bloc/tv_watchlist_bloc/tv_watchlist_bloc.dart';
import 'package:tv/presentation/bloc/season_detail_bloc/season_detail_bloc.dart';

import 'package:tv/presentation/pages/home_tv_page.dart';
import 'package:tv/presentation/pages/now_playing_tv_page.dart';
import 'package:tv/presentation/pages/popular_tv_page.dart';
import 'package:tv/presentation/pages/search_tv_page.dart';
import 'package:tv/presentation/pages/season_detail_page.dart';
import 'package:tv/presentation/pages/top_rated_tv_page.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';
import 'package:tv/presentation/pages/watchlist_tv_page.dart';

import 'package:core/core.dart';
import 'package:core/ssl/http_ssl_pinning.dart';
import 'package:about/about_page.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await HttpSSLPinning.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  // await analytics.logAppOpen();

  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<MovieSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieNowPlayingBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviePopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieWatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvNowPlayingBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvPopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvWatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeasonDetailBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case homeMoviePage:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case popularMoviePage:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case topRatedMoviePage:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case movieDetailPage:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case searchPage:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case watchlistMoviePage:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            //Tv Routes
            case homeTvPage:
              return MaterialPageRoute(builder: (_) => HomeTvPage());
            case nowPlayingTvPage:
              return MaterialPageRoute(builder: (_) => NowPlayingTvPage());
            case popularTvPage:
              return MaterialPageRoute(builder: (_) => PopularTvPage());
            case topRatedTvPage:
              return MaterialPageRoute(builder: (_) => TopRatedTvPage());
            case tvDetailPage:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case searchTvPage:
              return MaterialPageRoute(builder: (_) => SearchTvPage());
            case watchlistTvPage:
              return MaterialPageRoute(builder: (_) => WatchlistTvPage());

            case seasonDetailPage:
              final args = settings.arguments as ScreenArguments;
              return MaterialPageRoute(
                builder: (_) => SeasonDetailPage(
                  id: args.id,
                  seasonNumber: args.seasonNumber,
                  posterPath: args.posterPath,
                ),
                settings: settings,
              );

            case aboutPage:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
