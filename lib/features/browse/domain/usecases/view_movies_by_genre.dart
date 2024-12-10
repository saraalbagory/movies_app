import 'package:movies_app/features/browse/data/models/GenresModel.dart';
import 'package:movies_app/features/browse/data/models/moviesByGenre.dart';
import 'package:movies_app/features/browse/domain/repositoy/movies_by_genre_repo.dart';

class ViewMoviesByGenre {
  MoviesByGenreRepo moviesByGenreRepo;
  ViewMoviesByGenre(this.moviesByGenreRepo);
  Future<List<Results>> call(Genre genre) =>
      moviesByGenreRepo.getMoviesByGenre(genre);
}
