part of 'tv_watchlist_status_bloc.dart';

abstract class TvWatchlistStatusState extends Equatable {
  const TvWatchlistStatusState();

  @override
  List<Object> get props => [];
}

class TvWatchlistStatusInitial extends TvWatchlistStatusState {}

class TvWatchlistRemoved extends TvWatchlistStatusState {
  final String message;

  TvWatchlistRemoved(this.message);

  @override
  List<Object> get props => [message];
}

class TvWatchlistAdded extends TvWatchlistStatusState {
  final String message;

  TvWatchlistAdded(this.message);

  @override
  List<Object> get props => [message];
}

class FailedToModifiyWatchlist extends TvWatchlistStatusState {
  final String message;

  FailedToModifiyWatchlist(this.message);

  @override
  List<Object> get props => [message];
}

class IsInWatchlist extends TvWatchlistStatusState {}

class IsNotInWatchlist extends TvWatchlistStatusState {}
