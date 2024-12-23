import 'package:movies_app/features/movies/data/models/get_movies_response.dart';

abstract class ApiMoviesSources {
  Future<GetMoviesResponse> getPopularMovies();
  Future<GetMoviesResponse> getNewlyReleasedMovies();
  Future<GetMoviesResponse> getRecommendedMovies();
  Future<GetMoviesResponse> getSimilarMovies(String movieId);
}