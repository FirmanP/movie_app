import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/network.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:ditonton/presentation/bloc/tv/tv_watchlist_status_bloc/tv_watchlist_status_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_watchlist_status_bloc_test.mocks.dart';

@GenerateMocks([SaveWatchlistTv, RemoveWatchlistTv, GetWatchListStatusTv])
void main() {
  late TvWatchlistStatusBloc tvWatchlistStatusBloc;
  late MockSaveWatchlistTv mockSaveWatchlist;
  late MockRemoveWatchlistTv mockRemoveWatchlist;
  late MockGetWatchListStatusTv mockGetWatchListStatus;

  setUp(() {
    mockSaveWatchlist = MockSaveWatchlistTv();
    mockRemoveWatchlist = MockRemoveWatchlistTv();
    mockGetWatchListStatus = MockGetWatchListStatusTv();
    tvWatchlistStatusBloc = TvWatchlistStatusBloc(
        mockGetWatchListStatus, mockSaveWatchlist, mockRemoveWatchlist);
  });

  test('initial state should be empty', () {
    expect(tvWatchlistStatusBloc.state, TvWatchlistStatusInitial());
  });
  final testTvDetail = TvDetail(
      adult: false,
      backdropPath: "/gNPWlhUXhyWiHv9qxr57tvT0WwS.jpg",
      firstAirDate: "2014-10-07",
      genres: [Genre(id: 1, name: 'Action')],
      homepage: "http://www.cwtv.com/shows/the-flash/",
      id: 1,
      inProduction: false,
      languages: ["en"],
      lastAirDate: "2023-05-24",
      name: "The Flash",
      networks: [
        Network(
            id: 71,
            logoPath: "/ge9hzeaU7nMtQ4PjkFlc68dGAJ9.png",
            name: "The CW",
            originCountry: "US")
      ],
      numberOfEpisodes: 184,
      numberOfSeasons: 9,
      originCountry: ["US"],
      originalLanguage: "en",
      originalName: "The Flash",
      overview: "overview",
      popularity: 974.777,
      posterPath: "/rg8N7x27Ef6PvlIiioLStf9ZaIO.jpg",
      seasons: [
        Season(
            airDate: "2015-10-06",
            episodeCount: 23,
            id: 66922,
            name: "Season 2",
            overview: "overview",
            posterPath: "/8xWZPVX1cv9V5YD1RPeLj9QZDE9.jpg",
            seasonNumber: 2)
      ],
      status: "Ended",
      tagline: "The fastest man alive.",
      type: "Scripted",
      voteAverage: 7.797,
      voteCount: 10436);

  blocTest<TvWatchlistStatusBloc, TvWatchlistStatusState>(
    'should get the watchlist status',
    build: () {
      when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => true);
      return tvWatchlistStatusBloc;
    },
    act: (bloc) => bloc.add(LoadTvWatchlistStatus(1)),
    wait: const Duration(milliseconds: 100),
    expect: () => [IsInWatchlist()],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(1));
    },
  );

  blocTest<TvWatchlistStatusBloc, TvWatchlistStatusState>(
    'should execute save watchlist when function called',
    build: () {
      when(mockSaveWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchListStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => true);
      return tvWatchlistStatusBloc;
    },
    act: (bloc) => bloc.add(AddTvToWatchlist(testTvDetail)),
    wait: const Duration(milliseconds: 100),
    expect: () => [TvWatchlistAdded('Success'), IsInWatchlist()],
    verify: (bloc) {
      verifyNever(mockGetWatchListStatus.execute(1));
    },
  );
  blocTest<TvWatchlistStatusBloc, TvWatchlistStatusState>(
    'should execute remove watchlist when function called',
    build: () {
      when(mockRemoveWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchListStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => false);
      return tvWatchlistStatusBloc;
    },
    act: (bloc) => bloc.add(RemoveTvFromWatchlist(testTvDetail)),
    wait: const Duration(milliseconds: 100),
    expect: () => [TvWatchlistRemoved('Removed'), IsNotInWatchlist()],
    verify: (bloc) {
      verifyNever(mockGetWatchListStatus.execute(1));
    },
  );
}
