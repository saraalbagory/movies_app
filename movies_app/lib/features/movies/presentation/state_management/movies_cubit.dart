import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/movies/domain/usecases/view_newly_released_movies.dart';
import 'package:movies_app/features/movies/domain/usecases/view_popular_movies.dart';
import 'package:movies_app/features/movies/domain/usecases/view_recommended_movies.dart';
import 'package:movies_app/features/movies/domain/usecases/view_similar_movies.dart';
import 'package:movies_app/features/movies/presentation/state_management/movies_cubit_states.dart';
import 'package:movies_app/support/resources/locators/api_locator.dart';

class MoviesCubit extends Cubit<MoviesCubitState> {

  late ViewPopularMovies _popularMoviesUseCase;
  late ViewNewlyReleasedMovies _newlyReleasedMoviesUseCase;
  late ViewRecommendedMovies _recommendedMoviesUseCase;
  late ViewSimilarMovies _similarMoviesUseCase;
  
  MoviesCubit() : super(IntialMovieState()) {
    _newlyReleasedMoviesUseCase=ViewNewlyReleasedMovies(ApiLocator.moviesRepository);
    _popularMoviesUseCase=ViewPopularMovies(ApiLocator.moviesRepository);
    _recommendedMoviesUseCase=ViewRecommendedMovies(ApiLocator.moviesRepository);
    _similarMoviesUseCase=ViewSimilarMovies(ApiLocator.moviesRepository);
  }
  void getPopularMovies() async {
    emit(LoadingMovieState());
    try {
      var popularMovies = await _popularMoviesUseCase();
      print(popularMovies.length);
      emit(SuccessfulMovieState(movies: popularMovies));
    } catch (e) {
      emit(ErrorMovieState(errorMessage: e.toString()));
    }
  }
  void getRecommendMovies() async {
    emit(LoadingMovieState());
    try {
      var recommendMovies = await _recommendedMoviesUseCase();
      print(recommendMovies.length);
      emit(SuccessfulMovieState(movies: recommendMovies));
    } catch (e) {
      emit(ErrorMovieState(errorMessage: e.toString()));
    }
  }
  void getNewlyReleasedMovies() async {
    emit(LoadingMovieState());
    try {
      var movies = await _newlyReleasedMoviesUseCase();
      print(movies.length);
      emit(SuccessfulMovieState(movies: movies));
    } catch (e) {
      emit(ErrorMovieState(errorMessage: e.toString()));
    }
  }

  void getSimilarMovies(String movieId) async {
    emit(LoadingMovieState());
    try {
      var movies = await _similarMoviesUseCase(movieId);
      print(movies.length);
      emit(SuccessfulMovieState(movies: movies));
    } catch (e) {
      emit(ErrorMovieState(errorMessage: e.toString()));
    }
  }

  
}
