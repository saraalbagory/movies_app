import 'package:movies_app/features/movies/data/models/GenresModel.dart';
import 'package:movies_app/features/movies/data/models/moviesByGenre.dart';

abstract class ApiMoviesByGenre {
  Future<MoviesByGenre> getMoviesByGenre(Genre genre);
}
