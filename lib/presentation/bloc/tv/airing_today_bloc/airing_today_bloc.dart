import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_airing_today_tvs.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/tv.dart';

part 'airing_today_event.dart';
part 'airing_today_state.dart';

class AiringTodayBloc extends Bloc<AiringTodayEvent, AiringTodayState> {
  final GetAiringTodayTvs _getAiringTodayTvs;
  AiringTodayBloc(this._getAiringTodayTvs) : super(AiringTodayInitial()) {
    on<LoadAiringToday>((event, emit) async {
      emit(AiringTodayLoading());

      final result = await _getAiringTodayTvs.execute();
      result.fold(
        (failure) {
          emit(AiringTodayError(failure.message));
        },
        (moviesData) {
          emit(AiringTodayHasData(moviesData));
        },
      );
    });
  }
}
