import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:core/common/state_enum.dart';
import 'package:core/common/utils.dart';
import '../bloc/tv_watchlist_bloc/tv_watchlist_state.dart';
import '../bloc/tv_watchlist_bloc/tv_watchlist_event.dart';
import '../bloc/tv_watchlist_bloc/tv_watchlist_bloc.dart';
import '../widgets/tv_card_list.dart';

class WatchlistTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv';
  const WatchlistTvPage({Key? key}) : super(key: key);

  @override
  State<WatchlistTvPage> createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<TvWatchlistBloc>().add(OnFetchTvWatchlist());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<TvWatchlistBloc>().add(OnFetchTvWatchlist());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvWatchlistBloc, TvWatchlistState>(
          builder: (context, state) {
            if (state is WatchlistLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Tv = state.result[index];
                  return TvCard(Tv);
                },
                itemCount: state.result.length,
              );
            } else if (state is WatchlistError) {
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
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
