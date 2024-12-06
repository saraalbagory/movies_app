import 'package:movies_app/features/movies/data/data_sources/api_movies_sources.dart';
import 'package:movies_app/features/movies/domain/entites/movie_model.dart';
import 'package:movies_app/features/movies/domain/repositry/movies_repositry.dart';

class ViewNewlyReleasedMovies {
  MoviesRepository moviesRepository;
  ViewNewlyReleasedMovies(this.moviesRepository);
  Future<List<MovieModel>> call()=>moviesRepository.getNewlyReleasedMovies();
}