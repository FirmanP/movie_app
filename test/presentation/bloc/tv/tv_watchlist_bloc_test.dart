import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvs.dart';
import 'package:ditonton/presentation/bloc/tv/tv_watchlist_bloc/tv_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvs])
void main() {
  late TvWatchlistBloc tvWatchlistBloc;
  late MockGetWatchlistTvs mockGetWatchlistTvs;

  setUp(() {
    mockGetWatchlistTvs = MockGetWatchlistTvs();
    tvWatchlistBloc = TvWatchlistBloc(mockGetWatchlistTvs);
  });

  final tTvModel = Tv(
      backdropPath: "/t2rAdgjSh0WYbXzdOB5zTDqzdCI.jpg",
      firstAirDate: "2022-11-02",
      genreIds: [18],
      id: 213713,
      name: "Faltu",
      originCountry: ["IN"],
      originalLanguage: "hi",
      originalName: "Faltu",
      overview:
          "What's in a name? Amidst the arid landscape of Rajasthan, a young woman with dreamy eyes struggles to prove her worth.",
      popularity: 2627.101,
      posterPath: "/lgyFuoXs7GvKJN0mNm7z7OMOFuZ.jpg",
      voteAverage: 4.5,
      voteCount: 25);
  final tTvList = <Tv>[tTvModel];

  test('initial state should be empty', () {
    expect(tvWatchlistBloc.state, TvWatchlistInitial());
  });
  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTvs.execute())
          .thenAnswer((_) async => Right(tTvList));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(LoadTvWatchlist()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TvWatclistLoading(),
      TvWatclistHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvs.execute());
    },
  );

  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'Should emit [Loading, Error] when get TvWatchlist is unsuccessful',
    build: () {
      when(mockGetWatchlistTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(LoadTvWatchlist()),
    expect: () => [
      TvWatclistLoading(),
      TvWatclistError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvs.execute());
    },
  );
}
