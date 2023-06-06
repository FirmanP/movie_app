import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/tv.dart';
import '../../../../domain/usecases/get_popular_tvs.dart';

part 'popular_tvs_event.dart';
part 'popular_tvs_state.dart';

class PopularTvsBloc extends Bloc<PopularTvsEvent, PopularTvsState> {
  final GetPopularTvs _getNowPopularTvs;
  PopularTvsBloc(this._getNowPopularTvs) : super(PopularTvsInitial()) {
    on<LoadPopularTvs>((event, emit) async {
      emit(PopularTvsLoading());

      final result = await _getNowPopularTvs.execute();
      result.fold(
        (failure) {
          emit(PopularTvsError(failure.message));
        },
        (data) {
          emit(PopularTvsHasData(data));
        },
      );
    });
  }
}
