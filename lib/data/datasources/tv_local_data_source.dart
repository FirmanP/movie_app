import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/tv_table.dart';

abstract class TvLocalDataSource {
  Future<String> insertTvWatchlist(TvTable tv);
  Future<String> removeTvWatchlist(TvTable tv);
  Future<TvTable?> getTvById(int id);
  Future<List<TvTable>> getWatchlistTvs(); 
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvLocalDataSourceImpl({required this.databaseHelper});
 
  @override
  Future<String> insertTvWatchlist(TvTable tv) async {
    try {
      await databaseHelper.insertTvWatchlist(tv);
      return 'Added to TV Series Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeTvWatchlist(TvTable tv) async {
    try {
      await databaseHelper.removeTvWatchlist(tv);
      return 'Removed from TV series Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvTable?> getTvById(int id) async {
    final result = await databaseHelper.getTvById(id);
    if (result != null) {
      return TvTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvTable>> getWatchlistTvs() async {
    final result = await databaseHelper.getWatchlistTvs();
    return result.map((data) => TvTable.fromMap(data)).toList();
  }
}
