import 'package:movies_app/features/movies/domain/entites/movie_model.dart';
import 'package:movies_app/features/movies/domain/repositry/movies_repositry.dart';

class ViewRecommendedMovies {
  MoviesRepository moviesRepository;
  ViewRecommendedMovies(this.moviesRepository);
  Future<List<MovieModel>> call()=>moviesRepository.getRecommenedMovies();
}