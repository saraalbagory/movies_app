import 'package:get_it/get_it.dart';
import 'package:movies_app/features/browse/data/data_sources/api_genres_get_impl.dart';
import 'package:movies_app/features/browse/data/data_sources/api_movies_by_genre_impl.dart';
import 'package:movies_app/features/browse/data/data_sources/api_search_results_impl.dart';
import 'package:movies_app/features/browse/data/repository/genres_repo_impl.dart';
import 'package:movies_app/features/browse/data/repository/movies_by_genre_repo_impl.dart';
import 'package:movies_app/features/browse/data/repository/search_movies_repo_impl.dart';
import 'package:movies_app/features/browse/domain/usecases/search_by_name.dart';
import 'package:movies_app/features/browse/domain/usecases/view_genres.dart';
import 'package:movies_app/features/browse/domain/usecases/view_movies_by_genre.dart';
import 'package:movies_app/features/browse/presentation/bloc/genre_Movies/genre_movies_cubit.dart';
import 'package:movies_app/features/browse/presentation/bloc/genres/geners_cubit.dart';
import 'package:movies_app/features/browse/presentation/bloc/search/search_cubit.dart';

final sl = GetIt.instance;

void browsingSetupLocator() {
  // API clients
  sl.registerLazySingleton(() => ApiGenresGetImpl());
  sl.registerLazySingleton(() => ApiSearchResultsImpl());
  sl.registerLazySingleton(() => ApiMoviesByGenreImpl());

  // repositories
  sl.registerLazySingleton(() => GenresRepoImpl(sl<ApiGenresGetImpl>()));
  sl.registerLazySingleton(
      () => SearchMoviesRepoImpl(sl<ApiSearchResultsImpl>()));
  sl.registerLazySingleton(
      () => MoviesByGenreRepoImpl(sl<ApiMoviesByGenreImpl>()));

  // use cases
  sl.registerLazySingleton(() => ViewGenres(sl<GenresRepoImpl>()));
  sl.registerLazySingleton(() => SearchByName(sl<SearchMoviesRepoImpl>()));
  sl.registerLazySingleton(
      () => ViewMoviesByGenre(sl<MoviesByGenreRepoImpl>()));

  // cubit
  sl.registerFactory(() => GenresCubit(sl<ViewGenres>()));
  sl.registerFactory(() => SearchCubit(sl<SearchByName>()));
  sl.registerFactory(() => MoviesByGenreCubit(sl<ViewMoviesByGenre>()));
}
