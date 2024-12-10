import 'package:movies_app/features/movies/domain/entites/movie_model.dart';
import 'package:movies_app/features/movies/domain/repositry/movies_repositry.dart';

class ViewSimilarMovies {
  MoviesRepository moviesRepository;
  ViewSimilarMovies(this.moviesRepository);
  Future<List<MovieModel>> call(String movieId) =>
      moviesRepository.getSimilarMovies(movieId);
}
