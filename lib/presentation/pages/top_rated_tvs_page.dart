
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/tv/top_rated_tvs_bloc/top_rated_tvs_bloc.dart';

class TopRatedTvsPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';

  @override
  _TopRatedTvsPageState createState() => _TopRatedTvsPageState();
}

class _TopRatedTvsPageState extends State<TopRatedTvsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        () => context.read<TopRatedTvsBloc>().add(LoadTopRatedTvs()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Tvs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvsBloc, TopRatedTvsState>(
          builder: (context, state) {
            if (state is TopRatedTvsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedTvsHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.data[index];
                  return TvCard(tv);
                },
                itemCount: state.data.length,
              );
            } else if (state is TopRatedTvsError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text('Failed'), 
              );
            }
          },
        ),
      ),
    );
  }
}
