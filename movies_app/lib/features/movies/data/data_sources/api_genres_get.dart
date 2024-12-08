import 'package:movies_app/features/movies/data/models/GenresModel.dart';

abstract class ApiGenresGet {
  Future<Genres> getAllGenres();
}
