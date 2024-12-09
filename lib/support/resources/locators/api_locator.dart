import 'package:movies_app/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:movies_app/features/authentication/domain/repository/auth_repository.dart';
import 'package:movies_app/features/movies/data/data_sources/api_movies_sources.dart';
import 'package:movies_app/features/movies/data/data_sources/api_movies_sources_impl.dart';
import 'package:movies_app/features/movies/data/repositry/movie_repositry_impl.dart';
import 'package:movies_app/features/movies/domain/repositry/movies_repositry.dart';
import 'package:movies_app/features/movies_details/data/data_source/movie_details_data_source.dart';
import 'package:movies_app/features/movies_details/data/data_source/movie_details_data_source_impl.dart';
import 'package:movies_app/features/movies_details/data/repositry/movie_details_repo_impl.dart';
import 'package:movies_app/features/movies_details/domain/repositry/movies_details_repositry.dart';

class ApiLocator {
  static ApiMoviesSources apiDataSource=ApiMoviesSourcesImpl();
  static MoviesRepository moviesRepository=MovieRepositoryImpl(apiDataSource);
  static AuthRepository authRepository = AuthRepositoryImpl();
}