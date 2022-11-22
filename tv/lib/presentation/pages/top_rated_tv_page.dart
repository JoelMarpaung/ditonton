import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:core/common/state_enum.dart';
import '../bloc/tv_top_rated_bloc/tv_top_rated_state.dart';
import '../bloc/tv_top_rated_bloc/tv_top_rated_event.dart';
import '../bloc/tv_top_rated_bloc/tv_top_rated_bloc.dart';
import '../provider/top_rated_tv_notifier.dart';
import '../widgets/tv_card_list.dart';

class TopRatedTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';
  const TopRatedTvPage({Key? key}) : super(key: key);

  @override
  State<TopRatedTvPage> createState() => _TopRatedTvPageState();
}

class _TopRatedTvPageState extends State<TopRatedTvPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvTopRatedBloc>().add(OnFetchTvTopRated());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvTopRatedBloc, TvTopRatedState>(
          builder: (context, state) {
            if (state is TopRatedLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Tv = state.result[index];
                  return TvCard(Tv);
                },
                itemCount: state.result.length,
              );
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
      ),
    );
  }
}
