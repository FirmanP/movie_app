import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/tv.dart';
import '../../../../domain/usecases/get_watchlist_tvs.dart';

part 'tv_watchlist_event.dart';
part 'tv_watchlist_state.dart';

class TvWatchlistBloc extends Bloc<TvWatchlistEvent, TvWatchlistState> {
  final GetWatchlistTvs _getWatchlistTvs;
  TvWatchlistBloc(this._getWatchlistTvs) : super(TvWatchlistInitial()) {
    on<LoadTvWatchlist>((event, emit) async {
      emit(TvWatclistLoading());

      final result = await _getWatchlistTvs.execute();
      result.fold(
        (failure) {
          emit(TvWatclistError(failure.message));
        },
        (data) {
          emit(TvWatclistHasData(data));
        },
      );
    });
  }
}
