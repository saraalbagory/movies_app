import 'package:movies_app/features/movies_details/data/mapper/geners_mapper.dart';
import 'package:movies_app/features/movies_details/data/models/get_movie_details_reponse.dart';
import 'package:movies_app/features/movies_details/domain/entites/movie_details_model.dart';

extension MovieDetailsMapper on GetMovieDetailResponse {
  MovieDetailsModel movieDetailsResToDetailsModel() => MovieDetailsModel(
        adult: adult,
        backdropPath: backdropPath,
        homepage: homepage,
        id: id,
        imdbId: imdbId,
        originCountry: originCountry,
        originalLanguage: originalLanguage,
        originalTitle: originalTitle,
        overview: overview,
        popularity: popularity,
        posterPath: posterPath,
        releaseDate: releaseDate,
        revenue: revenue,
        runtime: runtime,
        status: status,
        tagline: tagline,
        title: title,
        video: video,
        voteAverage: voteAverage,
        voteCount: voteCount,
        genres: genres!.map((genre) => genre.genresToGenreModel()).toList(),
      );
}
