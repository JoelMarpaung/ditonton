import 'package:about/about_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ditonton/main.dart' as app;
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/watchlist_movies_page.dart';
import 'package:tv/presentation/pages/home_tv_page.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';
import 'package:tv/presentation/pages/watchlist_tv_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('integration test', () {
    testWidgets('End to end integration testing', (tester) async {
      // home movie page
      app.main();
      await tester.pumpAndSettle();
      expect(find.byType(HomeMoviePage), findsOneWidget);

      // go to movie detail
      final movie = find.byType(InkWell).first;
      await tester.tap(movie);
      await tester.pumpAndSettle();
      expect(find.byType(MovieDetailPage), findsOneWidget);

      //press watchlist button
      final watchlistMovie = find.byType(ElevatedButton);
      await tester.tap(watchlistMovie);
      await tester.pumpAndSettle();
      expect(find.byType(SnackBar), findsOneWidget);

      //go back to movie page
      final NavigatorState navigator = tester.state(find.byType(Navigator));
      navigator.pop();
      await tester.pumpAndSettle();
      expect(find.byType(HomeMoviePage), findsOneWidget);

      //custom drawer
      final drawer = find.byTooltip('Open navigation menu');
      await tester.tap(drawer);
      await tester.pumpAndSettle();
      expect(find.byType(ListTile), findsNWidgets(5));

      // go to watchlist movie
      final watchlistMovieMenu = find.byType(ListTile);
      await tester.tap(watchlistMovieMenu.at(1));
      await tester.pumpAndSettle();
      expect(find.byType(WatchlistMoviesPage), findsOneWidget);

      //go back to drawer
      navigator.pop();
      await tester.pumpAndSettle();
      expect(find.byType(ListTile), findsNWidgets(5));

      // go to tv page
      await tester.tap(watchlistMovieMenu.at(2));
      await tester.pumpAndSettle();
      expect(find.byType(HomeTvPage), findsOneWidget);

      // go to tv detail
      final tv = find.byType(InkWell).at(1);
      await tester.tap(tv);
      await tester.pumpAndSettle();
      expect(find.byType(TvDetailPage), findsOneWidget);

      //press watchlist button
      final watchlistTv = find.byType(ElevatedButton);
      await tester.tap(watchlistTv);
      await tester.pumpAndSettle();
      expect(find.byType(SnackBar), findsOneWidget);

      //go back to movie page
      navigator.pop();
      await tester.pumpAndSettle();
      expect(find.byType(HomeTvPage), findsOneWidget);

      //custom drawer
      await tester.tap(drawer);
      await tester.pumpAndSettle();
      expect(find.byType(ListTile), findsNWidgets(5));

      // go to watchlist movie
      final watchlistTvMenu = find.byType(ListTile);
      await tester.tap(watchlistTvMenu.at(3));
      await tester.pumpAndSettle();
      expect(find.byType(WatchlistTvPage), findsOneWidget);

      //go back to drawer
      navigator.pop();
      await tester.pumpAndSettle();
      expect(find.byType(ListTile), findsNWidgets(5));

      // go to watchlist movie
      final aboutMenu = find.byType(ListTile);
      await tester.tap(aboutMenu.at(4));
      await tester.pumpAndSettle();
      expect(find.byType(AboutPage), findsOneWidget);

    });
  });
}
