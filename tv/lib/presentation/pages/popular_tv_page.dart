import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:core/common/state_enum.dart';
import '../bloc/tv_popular_bloc/tv_popular_event.dart';
import '../bloc/tv_popular_bloc/tv_popular_state.dart';
import '../bloc/tv_popular_bloc/tv_popular_bloc.dart';
import '../widgets/tv_card_list.dart';

class PopularTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';
  const PopularTvPage({Key? key}) : super(key: key);

  @override
  State<PopularTvPage> createState() => _PopularTvPageState();
}

class _PopularTvPageState extends State<PopularTvPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvPopularBloc>().add(OnFetchTvPopular());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvPopularBloc, TvPopularState>(
          builder: (context, state) {
            if (state is PopularLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Tv = state.result[index];
                  return TvCard(Tv);
                },
                itemCount: state.result.length,
              );
            } else if (state is PopularError) {
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
