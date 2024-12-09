import 'package:movies_app/features/browse/data/models/GenresModel.dart';

abstract class ApiGenresGet {
  Future<Genres> getAllGenres();
}
