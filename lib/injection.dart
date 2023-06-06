// import 'dart:io';

import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:ditonton/domain/usecases/get_airing_today_tvs.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_tvs.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvs.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recomendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvs.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_tvs.dart';
import 'package:ditonton/presentation/bloc/movie/movie_recommendations_bloc/movie_recommendations_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist_bloc/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist_status_bloc/movie_watchlist_status_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/airing_today_bloc/airing_today_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/search_tv_bloc/search_tv_bloc.dart';
import 'package:http/http.dart' as http;
// import 'package:http/io_client.dart' as ioc;
import 'package:get_it/get_it.dart';

import 'common/utils.dart';
import 'presentation/bloc/movie/movie_detail_bloc/movie_detail_bloc.dart';
import 'presentation/bloc/movie/now_playing_bloc/now_playing_bloc.dart';
import 'presentation/bloc/movie/popular_movies_bloc/popular_movies_bloc.dart';
import 'presentation/bloc/movie/search_bloc/search_bloc.dart';
import 'presentation/bloc/movie/top_rated_movies_bloc/top_rated_movies_bloc.dart';
import 'presentation/bloc/tv/popular_tvs_bloc/popular_tvs_bloc.dart';
import 'presentation/bloc/tv/top_rated_tvs_bloc/top_rated_tvs_bloc.dart';
import 'presentation/bloc/tv/tv_detail_bloc/tv_detail_bloc.dart';
import 'presentation/bloc/tv/tv_recommendations_bloc/tv_recommendations_bloc.dart';
import 'presentation/bloc/tv/tv_watchlist_bloc/tv_watchlist_bloc.dart';
import 'presentation/bloc/tv/tv_watchlist_status_bloc/tv_watchlist_status_bloc.dart';

final locator = GetIt.instance;

void init() {
  // provider
  // Movie

  locator.registerFactory(() => SearchBloc(locator()));
  locator.registerFactory(() => NowPlayingBloc(locator()));
  locator.registerFactory(() => TopRatedMoviesBloc(locator()));
  locator.registerFactory(() => PopularMoviesBloc(locator()));
  locator.registerFactory(() => MovieDetailBloc(locator()));
  locator.registerFactory(() => MovieRecommendationsBloc(locator()));
  locator.registerFactory(
      () => MovieWatchlistStatusBloc(locator(), locator(), locator()));
  locator.registerFactory(() => MovieWatchlistBloc(locator()));

  // Tv
  locator.registerFactory(() => SearchTvBloc(locator()));
  locator.registerFactory(() => AiringTodayBloc(locator()));
  locator.registerFactory(() => TopRatedTvsBloc(locator()));
  locator.registerFactory(() => PopularTvsBloc(locator()));
  locator.registerFactory(() => TvDetailBloc(locator()));
  locator.registerFactory(() => TvRecommendationsBloc(locator()));
  locator.registerFactory(
      () => TvWatchlistStatusBloc(locator(), locator(), locator()));
  locator.registerFactory(() => TvWatchlistBloc(locator()));

  // use case
  // Movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // Tv
  locator.registerLazySingleton(() => GetAiringTodayTvs(locator()));
  locator.registerLazySingleton(() => GetPopularTvs(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvs(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvs(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTv(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvs(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator(), sslHttp: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator(), sslHttp: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton<SSLHttp>(() => SSLHttp());
  // locator.registerLazySingleton(() async =>
  //     HttpClient(context: await globalContext).badCertificateCallback =
  //         (cert, host, port) => false);
  // locator.registerLazySingleton(() async => ioc.IOClient(locator()));
  // locator.registerLazySingleton(() async {
  //   HttpClient clienta = HttpClient(context: await globalContext);
  //   clienta.badCertificateCallback =
  //       (X509Certificate cert, String host, int port) => false;
  //   ioc.IOClient(clienta);
  // });
}
