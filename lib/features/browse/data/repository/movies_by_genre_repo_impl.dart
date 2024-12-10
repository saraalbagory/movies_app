import 'package:movies_app/features/browse/data/data_sources/api_movies_by_genre.dart';
import 'package:movies_app/features/browse/data/models/GenresModel.dart';
import 'package:movies_app/features/browse/data/models/moviesByGenre.dart';
import 'package:movies_app/features/browse/domain/repositoy/movies_by_genre_repo.dart';

class MoviesByGenreRepoImpl extends MoviesByGenreRepo {
  final ApiMoviesByGenre apiMoviesGenre;
  MoviesByGenreRepoImpl(this.apiMoviesGenre);
  @override
  Future<List<Results>> getMoviesByGenre(Genre genre) async {
    try {
      var response = await apiMoviesGenre.getMoviesByGenre(genre);

      if (response.results == null) {
        throw Exception("No results found.");
      }

      return response.results!;
    } catch (e) {
      print("Error in searchMovies: $e");
      throw Exception("Failed to fetch search results.");
    }
  }
}
