import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/movie.dart';

part 'movie_watchlist_event.dart'; 
part 'movie_watchlist_state.dart';
 
class MovieWatchlistBloc extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final GetWatchlistMovies _getWatchlistMovies;
  MovieWatchlistBloc(this._getWatchlistMovies) : super(MovieWatchlistInitial()) {
    on<LoadMovieWatchlist>((event, emit) async {
      emit(MovieWatclistLoading());

      final result = await _getWatchlistMovies.execute();
      result.fold(
        (failure) {
          emit(MovieWatclistError(failure.message));
        },
        (moviesData) {
          emit(MovieWatclistHasData(moviesData));
        },
      );
    });
  }
}
