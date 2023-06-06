import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/tv_detail.dart';
import '../../../../domain/usecases/get_tv_detail.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail _getTvDetail;
  TvDetailBloc(this._getTvDetail) : super(TvDetailInitial()) {
    on<LoadDetailTv>((event, emit) async {
      final id = event.id;
      emit(TvDetailLoading());
      final detailResult = await _getTvDetail.execute(id);
      detailResult.fold(
        (failure) {
          emit(TvDetailError(failure.message));
        },
        (movie) {
          emit(TvDetailHasData(movie));
        },
      );
    });
  }
}
