import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/movie_detail.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _getMovieDetail;

  MovieDetailBloc(this._getMovieDetail) : super(MovieDetailInitial()) {
    on<LoadDetailMovie>((event, emit) async {
      final id = event.id;
      emit(MovieDetailLoading());
      final detailResult = await _getMovieDetail.execute(id);
      detailResult.fold(
        (failure) {
          emit(MovieDetailError(failure.message));
        },
        (movie) {
          emit(MovieDetailHasData(movie));
        },
      );
    });
  }
}
