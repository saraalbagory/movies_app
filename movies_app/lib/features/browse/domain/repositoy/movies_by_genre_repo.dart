import 'package:movies_app/features/browse/data/models/GenresModel.dart';
import 'package:movies_app/features/browse/data/models/moviesByGenre.dart';

abstract class MoviesByGenreRepo {
  Future<List<Results>> getMoviesByGenre(Genre genre);
}
