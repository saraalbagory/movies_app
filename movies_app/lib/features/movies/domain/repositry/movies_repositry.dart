import 'package:movies_app/features/movies/domain/entites/movie_model.dart';

abstract class MoviesRepository {
  Future<List<MovieModel>> getMovies();
  Future<List<MovieModel>>  getNewlyReleasedMovies();
  Future<List<MovieModel>> getRecommenedMovies();
}
