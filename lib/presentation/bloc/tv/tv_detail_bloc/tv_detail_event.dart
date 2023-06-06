part of 'tv_detail_bloc.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();

  @override
  List<Object> get props => [];
}
 class LoadDetailTv extends TvDetailEvent {
  final int id;

  LoadDetailTv(this.id);

  @override
  List<Object> get props => [id];
}
