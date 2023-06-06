import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should be a subclass of Genre entity', () async {
    final tGenreModel = GenreModel(id: 1, name: "action");

    final tGenre = Genre(id: 1, name: "action");
    final result = tGenreModel.toEntity();
    expect(result, tGenre);
  });
}
