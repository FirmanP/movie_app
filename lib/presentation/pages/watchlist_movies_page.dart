
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist_bloc/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/tv/tv_watchlist_bloc/tv_watchlist_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieWatchlistBloc>().add(LoadMovieWatchlist());
      context.read<TvWatchlistBloc>().add(LoadTvWatchlist());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<MovieWatchlistBloc>().add(LoadMovieWatchlist());
    context.read<TvWatchlistBloc>().add(LoadTvWatchlist());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Watchlist'),
            bottom: TabBar(tabs: [
              Tab(
                text: 'Movies',
              ),
              Tab(
                text: 'TV Series',
              ),
            ]),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<MovieWatchlistBloc, MovieWatchlistState>(
                  builder: (context, state) {
                    if (state is MovieWatclistLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is MovieWatclistHasData) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          final movie = state.data[index];
                          return MovieCard(movie);
                        },
                        itemCount: state.data.length,
                      );
                    } else if (state is MovieWatclistError) {
                      return Center(
                        key: Key('error_message'),
                        child: Text(state.message),
                      );
                    } else {
                      return Text('Failed');
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:BlocBuilder<TvWatchlistBloc, TvWatchlistState>(
                  builder: (context, state) {
                    if (state is TvWatclistLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is TvWatclistHasData) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          final tv = state.data[index];
                          return TvCard(tv);
                        },
                        itemCount: state.data.length,
                      );
                    } else if (state is TvWatclistError) {
                      return Center(
                        key: Key('error_message'),
                        child: Text(state.message),
                      );
                    } else {
                      return Text('Failed');
                    }
                  },
                ),
              ),
            ],
          )),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
