part of 'tv_watchlist_bloc.dart';

abstract class TvWatchlistState extends Equatable {
  const TvWatchlistState();
  
  @override
  List<Object> get props => [];
}

class TvWatchlistInitial extends TvWatchlistState {}
class TvWatclistLoading extends TvWatchlistState {}

class TvWatclistError extends TvWatchlistState {
  final String message;
  
  TvWatclistError(this.message);
 
  @override
  List<Object> get props => [message];
}

class TvWatclistHasData extends TvWatchlistState {
  final List<Tv> data;
 
  TvWatclistHasData(this.data);
 
  @override
  List<Object> get props => [data];
}