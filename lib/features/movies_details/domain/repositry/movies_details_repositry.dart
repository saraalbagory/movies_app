import 'package:movies_app/features/movies_details/domain/entites/movie_details_model.dart';

abstract class MoviesDetailsRepositry {
  Future<MovieDetailsModel> fetchMovieDetails(String movieId);
}