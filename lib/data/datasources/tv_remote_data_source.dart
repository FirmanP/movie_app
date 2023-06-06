import 'dart:convert';

import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:ditonton/common/exception.dart';
import 'package:http/http.dart' as http;
// import 'package:http/io_client.dart' as ioc;

import '../../common/utils.dart';

abstract class TvRemoteDataSource {
  Future<List<TvModel>> getAiringTodayTvs();
  Future<List<TvModel>> getPopularTvs();
  Future<List<TvModel>> getTopRatedTvs();
  Future<TvDetailResponse> getTvDetail(int id);
  Future<List<TvModel>> getTvRecommendations(int id);
  Future<List<TvModel>> searchTvs(String query);
}

class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;
  final SSLHttp sslHttp;

  TvRemoteDataSourceImpl({required this.client, required this.sslHttp});

  // Future<http.Response> ioClientGet(String url) async {
  //   ioc.IOClient ioClient = ioc.IOClient(await sslHttp.getCertificate);
  //   return await ioClient.get(Uri.parse(url));
  // }

  @override
  Future<List<TvModel>> getAiringTodayTvs() async {
    final response = await sslHttp.ioClientGet('$BASE_URL/tv/airing_today?$API_KEY');

    if (response.statusCode == 200) { 
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvDetailResponse> getTvDetail(int id) async {
    final response = await sslHttp.ioClientGet('$BASE_URL/tv/$id?$API_KEY');
    if (response.statusCode == 200) {
      return TvDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTvRecommendations(int id) async {
    final response = await sslHttp.ioClientGet('$BASE_URL/tv/$id/recommendations?$API_KEY');

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getPopularTvs() async {
    final response = await sslHttp.ioClientGet('$BASE_URL/tv/popular?$API_KEY');

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTopRatedTvs() async {
    final response = await sslHttp.ioClientGet('$BASE_URL/tv/top_rated?$API_KEY');

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> searchTvs(String query) async {
    final response = await sslHttp.ioClientGet('$BASE_URL/search/tv?$API_KEY&query=$query');

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }
}
