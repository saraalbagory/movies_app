import 'package:movies_app/features/browse/data/models/GenresModel.dart';

abstract class GenresRepo {
  Future<List<Genre>> getAllGenres();
}
