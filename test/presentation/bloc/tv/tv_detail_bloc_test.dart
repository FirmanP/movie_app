import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/network.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/presentation/bloc/tv/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvDetail])
void main() {
  late TvDetailBloc tvDetailBloc;
  late MockGetTvDetail mockGetTvDetail;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    tvDetailBloc = TvDetailBloc(mockGetTvDetail);
  });

  test('initial state should be empty', () {
    expect(tvDetailBloc.state, TvDetailInitial());
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

  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTvDetail.execute(1))
          .thenAnswer((_) async => Right(testTvDetail));
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(LoadDetailTv(1)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TvDetailLoading(),
      TvDetailHasData(testTvDetail),
    ],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(1));
    },
  );

  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockGetTvDetail.execute(1))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(LoadDetailTv(1)),
    expect: () => [
      TvDetailLoading(),
      TvDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(1));
    },
  );
}
