import 'package:movies_app/features/movies/data/data_sources/api_movies_sources.dart';
import 'package:movies_app/features/movies/data/data_sources/api_movies_sources_impl.dart';
import 'package:movies_app/features/movies/data/repositry/movie_repositry_impl.dart';
import 'package:movies_app/features/movies/domain/repositry/movies_repositry.dart';

class ApiLocator {
  static ApiMoviesSources apiDataSource=ApiMoviesSourcesImpl();
  static MoviesRepository moviesRepository=MovieRepositoryImpl(apiDataSource);
}