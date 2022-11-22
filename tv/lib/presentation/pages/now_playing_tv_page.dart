import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bloc/tv_now_playing_bloc/tv_now_playing_bloc.dart';
import '../bloc/tv_now_playing_bloc/tv_now_playing_event.dart';
import '../bloc/tv_now_playing_bloc/tv_now_playing_state.dart';
import '../widgets/tv_card_list.dart';

class NowPlayingTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/playing-tv';
  const NowPlayingTvPage({Key? key}) : super(key: key);

  @override
  State<NowPlayingTvPage> createState() => _NowPlayingTvPageState();
}

class _NowPlayingTvPageState extends State<NowPlayingTvPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvNowPlayingBloc>().add(OnFetchTvNowPlaying());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvNowPlayingBloc, TvNowPlayingState>(
          builder: (context, state) {
            if (state is NowPlayingLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NowPlayingHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Tv = state.result[index];
                  return TvCard(Tv);
                },
                itemCount: state.result.length,
              );
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
      ),
    );
  }
}
