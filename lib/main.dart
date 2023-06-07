import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/firebase_options.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_recommendations_bloc/movie_recommendations_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist_bloc/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist_status_bloc/movie_watchlist_status_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/now_playing_bloc/now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/search_bloc/search_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/airing_today_bloc/airing_today_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/search_tv_bloc/search_tv_bloc.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/airing_today_tvs_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/popular_tvs_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/search_tv_page.dart';
import 'package:ditonton/presentation/pages/season_detail_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tvs_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

import 'presentation/bloc/movie/popular_movies_bloc/popular_movies_bloc.dart';
import 'presentation/bloc/movie/top_rated_movies_bloc/top_rated_movies_bloc.dart';
import 'presentation/bloc/tv/popular_tvs_bloc/popular_tvs_bloc.dart';
import 'presentation/bloc/tv/top_rated_tvs_bloc/top_rated_tvs_bloc.dart';
import 'presentation/bloc/tv/tv_detail_bloc/tv_detail_bloc.dart';
import 'presentation/bloc/tv/tv_recommendations_bloc/tv_recommendations_bloc.dart';
import 'presentation/bloc/tv/tv_watchlist_bloc/tv_watchlist_bloc.dart';
import 'presentation/bloc/tv/tv_watchlist_status_bloc/tv_watchlist_status_bloc.dart';
import 'presentation/pages/tv_detail_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //Movie
        BlocProvider(create: (_) => di.locator<SearchBloc>()),
        BlocProvider(create: (_) => di.locator<NowPlayingBloc>()),
        BlocProvider(create: (_) => di.locator<TopRatedMoviesBloc>()),
        BlocProvider(create: (_) => di.locator<PopularMoviesBloc>()),
        BlocProvider(create: (_) => di.locator<MovieDetailBloc>()),
        BlocProvider(create: (_) => di.locator<MovieRecommendationsBloc>()),
        BlocProvider(create: (_) => di.locator<MovieWatchlistStatusBloc>()),
        BlocProvider(create: (_) => di.locator<MovieWatchlistBloc>()),

        //Tv
        BlocProvider(create: (_) => di.locator<SearchTvBloc>()),
        BlocProvider(create: (_) => di.locator<AiringTodayBloc>()),
        BlocProvider(create: (_) => di.locator<TopRatedTvsBloc>()),
        BlocProvider(create: (_) => di.locator<PopularTvsBloc>()),
        BlocProvider(create: (_) => di.locator<TvDetailBloc>()),
        BlocProvider(create: (_) => di.locator<TvRecommendationsBloc>()),
        BlocProvider(create: (_) => di.locator<TvWatchlistStatusBloc>()),
        BlocProvider(create: (_) => di.locator<TvWatchlistBloc>()),
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
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case TvDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case SeasonDetailPage.ROUTE_NAME:
              final season = settings.arguments as Season;
              return MaterialPageRoute(
                builder: (_) => SeasonDetailPage(season: season),
                settings: settings,
              );
            case PopularTvsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvsPage());
            case TopRatedTvsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvsPage());
            case AiringTodayPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => AiringTodayPage());
            case SearchTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchTvPage());
            case AboutPage.ROUTE_NAME:
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
