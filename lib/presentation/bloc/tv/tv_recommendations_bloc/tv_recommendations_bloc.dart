import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/tv.dart';
import '../../../../domain/usecases/get_tv_recomendations.dart';

part 'tv_recommendations_event.dart';
part 'tv_recommendations_state.dart';

class TvRecommendationsBloc
    extends Bloc<TvRecommendationsEvent, TvRecommendationsState> {
  final GetTvRecommendations _getTvRecommendations;
  TvRecommendationsBloc(this._getTvRecommendations)
      : super(TvRecommendationsInitial()) {
    on<LoadTvRecommendations>((event, emit) async {
      final id = event.id;

      emit(TvRecommendationsLoading());
      final result = await _getTvRecommendations.execute(id);

      result.fold(
        (failure) {
          emit(TvRecommendationsError(failure.message));
        },
        (data) {
          emit(TvRecommendationsHasData(data));
        },
      );
    });
  }
}
