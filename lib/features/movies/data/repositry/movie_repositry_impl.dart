import 'package:movies_app/features/movies/data/data_sources/api_movies_sources.dart';
import 'package:movies_app/features/movies/data/mapper/movie_mapper.dart';
import 'package:movies_app/features/movies/domain/entites/movie_model.dart';
import 'package:movies_app/features/movies/domain/repositry/movies_repositry.dart';

class MovieRepositoryImpl extends MoviesRepository {
  final ApiMoviesSources apiMoviesSources;

  MovieRepositoryImpl(this.apiMoviesSources);

  @override
  Future<List<MovieModel>> getMovies() async {
    try {
      var apiResponse = await apiMoviesSources.getPopularMovies();

      if (apiResponse.results == null) {
        throw Exception('No results found');
      }

      return apiResponse.results!.map((movie) {
        return movie.movieResultToMovieModel();
      }).toList();
    } catch (e) {
      throw Exception(e.toString()); // Use Exception for better error handling
    }
  }

  @override
  Future<List<MovieModel>> getNewlyReleasedMovies() async {
    try {
      var apiResponse = await apiMoviesSources.getNewlyReleasedMovies();

      if (apiResponse.results == null) {
        throw Exception('No results found');
      }

      return apiResponse.results!.map((movie) {
        return movie.movieResultToMovieModel();
      }).toList();
    } catch (e) {
      throw Exception(e.toString()); // Use Exception for better error handling
    }
  }

  @override
  Future<List<MovieModel>> getRecommenedMovies() async {
    try {
      var apiResponse = await apiMoviesSources.getRecommendedMovies();

      if (apiResponse.results == null) {
        throw Exception('No results found');
      }

      return apiResponse.results!.map((movie) {
        return movie.movieResultToMovieModel();
      }).toList();
    } catch (e) {
      throw Exception(e.toString()); // Use Exception for better error handling
    }
  }

  @override
  Future<List<MovieModel>> getSimilarMovies(String movieId) async {
    try {
      var apiResponse = await apiMoviesSources.getSimilarMovies(movieId);
      return apiResponse.results!
          .map((movie) => movie.movieResultToMovieModel())
          .toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
