import 'package:movies_app/features/movies/data/models/get_movies_response.dart';
import 'package:movies_app/features/movies/domain/entites/movie_model.dart';

extension MovieMapper on MovieResults {
  MovieModel MovieResultToMovieMode() => MovieModel(
        adult: adult,
        backdropPath: backdropPath,
        genreIds: genreIds,
        id: id,
        originalLanguage: originalLanguage,
        originalTitle: originalTitle,
        overview: overview,
        popularity: popularity,
        posterPath: posterPath,
        releaseDate: releaseDate,
        title: title,
        video: video,
        voteAverage: voteAverage,
        voteCount: voteCount,
      );
}
