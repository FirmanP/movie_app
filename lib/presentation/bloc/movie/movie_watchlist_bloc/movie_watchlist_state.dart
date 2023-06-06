part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();
  
  @override
  List<Object> get props => [];
}

class MovieWatchlistInitial extends MovieWatchlistState {}

class MovieWatclistLoading extends MovieWatchlistState {}

class MovieWatclistError extends MovieWatchlistState {
  final String message;
  
  MovieWatclistError(this.message);
 
  @override
  List<Object> get props => [message];
}

class MovieWatclistHasData extends MovieWatchlistState {
  final List<Movie> data;
 
  MovieWatclistHasData(this.data);
 
  @override
  List<Object> get props => [data];
}