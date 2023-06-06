import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_recomendations.dart';
import 'package:ditonton/presentation/bloc/tv/tv_recommendations_bloc/tv_recommendations_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_recommendations_bloc_test.mocks.dart';

@GenerateMocks([GetTvRecommendations])
void main() {
  late TvRecommendationsBloc tvRecommendationsBloc;
  late MockGetTvRecommendations mockGetTvRecommendations;

  setUp(() {
    mockGetTvRecommendations = MockGetTvRecommendations();
    tvRecommendationsBloc = TvRecommendationsBloc(mockGetTvRecommendations);
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
    expect(tvRecommendationsBloc.state, TvRecommendationsInitial());
  });
  blocTest<TvRecommendationsBloc, TvRecommendationsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTvRecommendations.execute(1))
          .thenAnswer((_) async => Right(tTvList));
      return tvRecommendationsBloc;
    },
    act: (bloc) => bloc.add(LoadTvRecommendations(1)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TvRecommendationsLoading(),
      TvRecommendationsHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetTvRecommendations.execute(1));
    },
  );

  blocTest<TvRecommendationsBloc, TvRecommendationsState>(
    'Should emit [Loading, Error] when get TvRecommendations is unsuccessful',
    build: () {
      when(mockGetTvRecommendations.execute(1))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvRecommendationsBloc;
    },
    act: (bloc) => bloc.add(LoadTvRecommendations(1)),
    expect: () => [
      TvRecommendationsLoading(),
      TvRecommendationsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvRecommendations.execute(1));
    },
  );
}
