import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/movie.dart';
import '../../../../domain/usecases/get_popular_movies.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies _getNowPopularMovies;
  PopularMoviesBloc(this._getNowPopularMovies) : super(PopularMoviesInitial()) {
    on<LoadPopularMovies>((event, emit) async {
      emit(PopularMoviesLoading());

      final result = await _getNowPopularMovies.execute();
      result.fold(
        (failure) {
          emit(PopularMoviesError(failure.message));
        },
        (moviesData) {
          emit(PopularMoviesHasData(moviesData));
        },
      );
    });
  }
}
