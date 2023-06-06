part of 'tv_recommendations_bloc.dart';

abstract class TvRecommendationsEvent extends Equatable {
  const TvRecommendationsEvent();

  @override
  List<Object> get props => [];
}

class LoadTvRecommendations extends TvRecommendationsEvent {
  final int id;

  LoadTvRecommendations(this.id);

  @override
  List<Object> get props => [id];
}
