part of 'tv_watchlist_status_bloc.dart';

abstract class TvWatchlistStatusEvent extends Equatable {
  const TvWatchlistStatusEvent();

  @override
  List<Object> get props => [];
}

class LoadTvWatchlistStatus extends TvWatchlistStatusEvent {
  final int id;

  LoadTvWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class AddTvToWatchlist extends TvWatchlistStatusEvent {
  final TvDetail tv;

  AddTvToWatchlist(this.tv);

  @override
  List<Object> get props => [tv];
}

class RemoveTvFromWatchlist extends TvWatchlistStatusEvent {
  final TvDetail tv;

  RemoveTvFromWatchlist(this.tv);

  @override
  List<Object> get props => [tv];
}
