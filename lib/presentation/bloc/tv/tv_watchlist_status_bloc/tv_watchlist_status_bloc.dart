import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/tv_detail.dart';

part 'tv_watchlist_status_event.dart';
part 'tv_watchlist_status_state.dart';

class TvWatchlistStatusBloc
    extends Bloc<TvWatchlistStatusEvent, TvWatchlistStatusState> {
  final GetWatchListStatusTv _getWatchListStatusTv;
  final SaveWatchlistTv _saveWatchlistTv;
  final RemoveWatchlistTv _removeWatchlistTv;
  TvWatchlistStatusBloc(this._getWatchListStatusTv, this._saveWatchlistTv,
      this._removeWatchlistTv)
      : super(TvWatchlistStatusInitial()) {
    on<LoadTvWatchlistStatus>((event, emit) async {
      final result = await _getWatchListStatusTv.execute(event.id);
      result ? emit(IsInWatchlist()) : emit(IsNotInWatchlist());
    });
    on<AddTvToWatchlist>((event, emit) async {
      final tv = event.tv;
      final result = await _saveWatchlistTv.execute(tv);

      await result.fold(
        (failure) async {
          emit(FailedToModifiyWatchlist(failure.message));
        },
        (successMessage) async {
          emit(TvWatchlistAdded(successMessage));
          emit(IsInWatchlist());
        },
      );
    });
    on<RemoveTvFromWatchlist>((event, emit) async {
      final tv = event.tv;
      final result = await _removeWatchlistTv.execute(tv);

      await result.fold(
        (failure) async {
          emit(FailedToModifiyWatchlist(failure.message));
        },
        (successMessage) async {
          emit(TvWatchlistRemoved(successMessage));
          emit(IsNotInWatchlist());
        },
      );
    });
  }
}
