import 'package:movies_app/features/movies/domain/entites/movie_model.dart';
import 'package:movies_app/features/movies/domain/repositry/movies_repositry.dart';

class ViewPopularMovies {
  MoviesRepository moviesRepository;
  ViewPopularMovies(this.moviesRepository);
  Future<List<MovieModel>> call() => moviesRepository.getMovies();
}
