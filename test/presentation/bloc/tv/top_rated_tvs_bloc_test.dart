import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvs.dart';
import 'package:ditonton/presentation/bloc/tv/top_rated_tvs_bloc/top_rated_tvs_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tvs_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvs])
void main() {
  late TopRatedTvsBloc topRatedTvsBloc;
  late MockGetTopRatedTvs mockGetTopRatedTvs;

  setUp(() {
    mockGetTopRatedTvs = MockGetTopRatedTvs();
    topRatedTvsBloc = TopRatedTvsBloc(mockGetTopRatedTvs);
  });

  test('initial state should be empty', () {
    expect(topRatedTvsBloc.state, TopRatedTvsInitial());
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

  blocTest<TopRatedTvsBloc, TopRatedTvsState>(
    'Should emit [Loading, HasData] when data is gotten successfully on GetTopRatedTvs',
    build: () {
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Right(tTvList));
      return topRatedTvsBloc;
    },
    act: (bloc) => bloc.add(LoadTopRatedTvs()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TopRatedTvsLoading(),
      TopRatedTvsHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvs.execute());
    },
  );

  blocTest<TopRatedTvsBloc, TopRatedTvsState>(
    'Should emit [Loading, Error] when get search is unsuccessful on GetTopRatedTvs',
    build: () {
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedTvsBloc;
    },
    act: (bloc) => bloc.add(LoadTopRatedTvs()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TopRatedTvsLoading(),
      TopRatedTvsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvs.execute());
    },
  );
}
