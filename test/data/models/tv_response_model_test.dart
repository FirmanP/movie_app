import 'dart:convert';

import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvModel = TvModel(
    backdropPath: '/t2rAdgjSh0WYbXzdOB5zTDqzdCI.jpg',
    firstAirDate: '2022-11-02',
    genreIds: [18],
    id: 213713,
    name: 'Faltu',
    originCountry: ['IN'],
    originalLanguage: 'hi',
    originalName: 'Faltu',
    overview:
        "What's in a name? Amidst the arid landscape of Rajasthan, a young woman with dreamy eyes struggles to prove her worth.",
    popularity: 2627.101,
    posterPath: '/lgyFuoXs7GvKJN0mNm7z7OMOFuZ.jpg',
    voteAverage: 4.5,
    voteCount: 25,
  );
  final tTvResponseModel = TvResponse(tvList: <TvModel>[tTvModel]);
  group('fromJson', () {
    test('should return a valid TV model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/airing_today.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": '/t2rAdgjSh0WYbXzdOB5zTDqzdCI.jpg',
            "first_air_date": '2022-11-02',
            "genre_ids": [18],
            "id": 213713,
            "name": 'Faltu',
            "origin_country": ['IN'],
            "original_language": 'hi',
            "original_name": 'Faltu',
            "overview":
                "What's in a name? Amidst the arid landscape of Rajasthan, a young woman with dreamy eyes struggles to prove her worth.",
            "popularity": 2627.101,
            "poster_path": '/lgyFuoXs7GvKJN0mNm7z7OMOFuZ.jpg',
            "vote_average": 4.5,
            "vote_count": 25,
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
