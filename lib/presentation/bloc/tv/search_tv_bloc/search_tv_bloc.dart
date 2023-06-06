import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/search_tvs.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../domain/entities/tv.dart';

part 'search_tv_event.dart';
part 'search_tv_state.dart';

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTvState> {
  final SearchTvs _searchTvs;
  SearchTvBloc(this._searchTvs) : super(SearchTvEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchTvLoading());
      final result = await _searchTvs.execute(query);

      result.fold(
        (failure) {
          emit(SearchTvError(failure.message));
        },
        (data) {
          if (data.length == 0) {
            emit(SearchTvnNotFound('Tv series is not found :('));
          } else {
            emit(SearchTvHasData(data));
          }
        },
      );
    }, transformer: debounce(const Duration(microseconds: 500)));
  }
}
