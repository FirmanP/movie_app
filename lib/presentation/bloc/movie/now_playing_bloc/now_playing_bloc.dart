import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';

part 'now_playing_event.dart';
part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  final GetNowPlayingMovies _getNowPlayingMovies;


  NowPlayingBloc(this._getNowPlayingMovies)
      : super(NowPlayingInitial()) {
    on<LoadNowPlaying>((event, emit) async {
      emit(NowPlayingLoading());

      final result = await _getNowPlayingMovies.execute();
      result.fold(
        (failure) {
          emit(NowPlayingError(failure.message));
        },
        (moviesData) {
          emit(NowPlayingHasData(moviesData));
        },
      );
    });

    
  }
}
