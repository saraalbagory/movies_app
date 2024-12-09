import 'package:movies_app/features/browse/data/models/GenresModel.dart';
import 'package:movies_app/features/browse/data/models/moviesByGenre.dart';

abstract class ApiMoviesByGenre {
  Future<MoviesByGenre> getMoviesByGenre(Genre genre);
}
