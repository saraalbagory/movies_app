import 'package:movies_app/features/movies_details/domain/entites/movie_details_model.dart';
import 'package:movies_app/features/movies_details/domain/repositry/movies_details_repositry.dart';

class ViewMoviesDetails {
  final MoviesDetailsRepositry _moviesDetailsRepositry;
  ViewMoviesDetails(this._moviesDetailsRepositry);
  Future<MovieDetailsModel> call(String movieId) =>
      _moviesDetailsRepositry.fetchMovieDetails(movieId);
}
