import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_airing_today_tvs.dart';
import 'package:ditonton/presentation/bloc/tv/airing_today_bloc/airing_today_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'airing_today_bloc_test.mocks.dart';


@GenerateMocks([GetAiringTodayTvs])
void main() {
  late AiringTodayBloc airingTodayBloc;
  late MockGetAiringTodayTvs mockGetAiringTodayTvs;

  setUp(() {
    mockGetAiringTodayTvs = MockGetAiringTodayTvs();
    airingTodayBloc = AiringTodayBloc(mockGetAiringTodayTvs);
  });

  test('initial state should be empty', () {
    expect(airingTodayBloc.state, AiringTodayInitial());
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

  blocTest<AiringTodayBloc, AiringTodayState>(
    'Should emit [Loading, HasData] when data is gotten successfully on GetAiringToday',
    build: () {
      when(mockGetAiringTodayTvs.execute())
          .thenAnswer((_) async => Right(tTvList));
      return airingTodayBloc;
    },
    act: (bloc) => bloc.add(LoadAiringToday()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      AiringTodayLoading(),
      AiringTodayHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetAiringTodayTvs.execute());
    },
  );

   blocTest<AiringTodayBloc, AiringTodayState>(
    'Should emit [Loading, Error] when get search is unsuccessful on GetAiringToday',
    build: () {
      when(mockGetAiringTodayTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return airingTodayBloc;
    },
    act: (bloc) => bloc.add(LoadAiringToday()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      AiringTodayLoading(),
      AiringTodayError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetAiringTodayTvs.execute());
    },
  );

  

 
}
