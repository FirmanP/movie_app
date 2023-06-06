part of 'movie_watchlist_status_bloc.dart';

abstract class MovieWatchlistStatusState extends Equatable {
  const MovieWatchlistStatusState();

  @override
  List<Object> get props => [];
}

class MovieWatchlistStatusInitial extends MovieWatchlistStatusState {}

class MovieWatchlistRemoved extends MovieWatchlistStatusState {
  final String message;

  MovieWatchlistRemoved(this.message);

  @override
  List<Object> get props => [message];
}

class MovieWatchlistAdded extends MovieWatchlistStatusState {
  final String message;

  MovieWatchlistAdded(this.message);

  @override
  List<Object> get props => [message];
}

class FailedToModifiyWatchlist extends MovieWatchlistStatusState {
  final String message;

  FailedToModifiyWatchlist(this.message);

  @override
  List<Object> get props => [message];
}

class IsInWatchlist extends MovieWatchlistStatusState {}

class IsNotInWatchlist extends MovieWatchlistStatusState {}
