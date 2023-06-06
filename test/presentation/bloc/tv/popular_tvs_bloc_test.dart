 import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tvs.dart';
import 'package:ditonton/presentation/bloc/tv/popular_tvs_bloc/popular_tvs_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tvs_bloc_test.mocks.dart';


@GenerateMocks([GetPopularTvs])
void main() {
  late PopularTvsBloc popularTvsBloc;
  late MockGetPopularTvs mockGetPopularTvs;

  setUp(() {
    mockGetPopularTvs = MockGetPopularTvs();
    popularTvsBloc = PopularTvsBloc(mockGetPopularTvs);
  });

  test('initial state should be empty', () {
    expect(popularTvsBloc.state, PopularTvsInitial());
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
    voteCount: 25
  );
  final tTvList = <Tv>[tTvModel];

   blocTest<PopularTvsBloc, PopularTvsState>(
    'Should emit [Loading, HasData] when data is gotten successfully on GetPopularTvs',
    build: () {
      when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => Right(tTvList));
      return popularTvsBloc;
    },
    act: (bloc) => bloc.add(LoadPopularTvs()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      PopularTvsLoading(),
      PopularTvsHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvs.execute());
    },
  );

   blocTest<PopularTvsBloc, PopularTvsState>(
    'Should emit [Loading, Error] when get search is unsuccessful on GetPopularTvs',
    build: () {
      when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularTvsBloc;
    },
    act: (bloc) => bloc.add(LoadPopularTvs()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      PopularTvsLoading(),
      PopularTvsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvs.execute());
    },
  );
}
