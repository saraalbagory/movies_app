import 'package:movies_app/features/movies/data/data_sources/api_movies_sources.dart';
import 'package:movies_app/features/movies/data/data_sources/api_movies_sources_impl.dart';

class ApiLocator {
  static ApiMoviesSources apiDataSource=ApiMoviesSourcesImpl();
}