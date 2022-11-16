import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:flutter/material.dart';

import '../pages/about_page.dart';
import '../pages/home_tv_page.dart';
import '../pages/watchlist_movies_page.dart';
import '../pages/watchlist_tv_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/circle-g.png'),
            ),
            accountName: Text('Ditonton'),
            accountEmail: Text('ditonton@dicoding.com'),
          ),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text('Movies'),
            onTap: () {
              Navigator.pushNamed(context, HomeMoviePage.ROUTE_NAME);
              //Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.save_alt),
            title: Text('Watchlist Movie'),
            onTap: () {
              Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
            },
          ),
          ListTile(
            leading: Icon(Icons.tv),
            title: Text('Tv Series'),
            onTap: () {
              Navigator.pushNamed(context, HomeTvPage.ROUTE_NAME);
              //Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.save_alt),
            title: Text('Watchlist Tv Series'),
            onTap: () {
              Navigator.pushNamed(context, WatchlistTvPage.ROUTE_NAME);
            },
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
            },
            leading: Icon(Icons.info_outline),
            title: Text('About'),
          ),
        ],
      ),
    );
  }
}
