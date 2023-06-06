import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist_status_bloc/movie_watchlist_status_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_watchlist_status_bloc_test.mocks.dart';

@GenerateMocks([SaveWatchlist, RemoveWatchlist, GetWatchListStatus])
void main() {
  late MovieWatchlistStatusBloc movieWatchlistStatusBloc;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockGetWatchListStatus mockGetWatchListStatus;

  setUp(() {
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockGetWatchListStatus = MockGetWatchListStatus();
    movieWatchlistStatusBloc = MovieWatchlistStatusBloc(
        mockGetWatchListStatus, mockSaveWatchlist, mockRemoveWatchlist);
  });

  test('initial state should be empty', () {
    expect(movieWatchlistStatusBloc.state, MovieWatchlistStatusInitial());
  });
  final testMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  blocTest<MovieWatchlistStatusBloc, MovieWatchlistStatusState>(
    'should get the watchlist status',
    build: () {
      when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => true);
      return movieWatchlistStatusBloc;
    },
    act: (bloc) => bloc.add(LoadWatchlistStatus(1)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      IsInWatchlist()
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(1));
    },
  );

  blocTest<MovieWatchlistStatusBloc, MovieWatchlistStatusState>(
    'should execute save watchlist when function called',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchListStatus.execute(testMovieDetail.id))
          .thenAnswer((_) async => true);
      return movieWatchlistStatusBloc;
    },
    act: (bloc) => bloc.add(AddMovieToWatchlist(testMovieDetail)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      MovieWatchlistAdded('Success'),
      IsInWatchlist()
    ],
    verify: (bloc) {
      verifyNever(mockGetWatchListStatus.execute(1));
    },
  );
  blocTest<MovieWatchlistStatusBloc, MovieWatchlistStatusState>(
    'should execute remove watchlist when function called',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchListStatus.execute(testMovieDetail.id))
          .thenAnswer((_) async => false);
      return movieWatchlistStatusBloc;
    },
    act: (bloc) => bloc.add(RemoveMovieFromWatchlist(testMovieDetail)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      MovieWatchlistRemoved('Removed'),
      IsNotInWatchlist()
    ],
    verify: (bloc) {
      verifyNever(mockGetWatchListStatus.execute(1));
    },
  );
}
 