import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'movie_watchlist_status_event.dart';
part 'movie_watchlist_status_state.dart';

class MovieWatchlistStatusBloc
    extends Bloc<MovieWatchlistStatusEvent, MovieWatchlistStatusState> {
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;
  MovieWatchlistStatusBloc(
      this._getWatchListStatus, this._saveWatchlist, this._removeWatchlist)
      : super(MovieWatchlistStatusInitial()) {
    on<LoadWatchlistStatus>((event, emit) async {
      final result = await _getWatchListStatus.execute(event.id);
      result ? emit(IsInWatchlist()) : emit(IsNotInWatchlist());
    });
    on<AddMovieToWatchlist>((event, emit) async {
      final movie = event.movie;
      final result = await _saveWatchlist.execute(movie);

      await result.fold(
        (failure) async {
          emit(FailedToModifiyWatchlist(failure.message));
        },
        (successMessage) async {
          emit(MovieWatchlistAdded(successMessage));
          emit(IsInWatchlist());
        },
      );
    });
    on<RemoveMovieFromWatchlist>((event, emit) async {
      final movie = event.movie;
      final result = await _removeWatchlist.execute(movie);

      await result.fold(
        (failure) async {
          emit(FailedToModifiyWatchlist(failure.message));
        },
        (successMessage) async {
          emit(MovieWatchlistRemoved(successMessage));
          emit(IsNotInWatchlist());
        },
      );
    });
  }
}
