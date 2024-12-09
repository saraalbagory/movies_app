import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/movies/domain/repositry/movies_repositry.dart';
import 'package:movies_app/features/movies/presentation/state_management/movies_cubit_states.dart';
import 'package:movies_app/support/resources/locators/api_locator.dart';

class MoviesCubit extends Cubit<MoviesCubitState> {
  late MoviesRepository moviesRepository;
  MoviesCubit() : super(IntialMovieState()) {
    moviesRepository = ApiLocator.moviesRepository;
  }
  void getPopularMovies() async {
    emit(LoadingMovieState());
    try {
      var popularMovies = await moviesRepository.getMovies();
      print(popularMovies.length);
      emit(SuccessfulMovieState(movies: popularMovies));
    } catch (e) {
      emit(ErrorMovieState(errorMessage: e.toString()));
    }
  }
  void getRecommendMovies() async {
    emit(LoadingMovieState());
    try {
      var recommendMovies = await moviesRepository.getRecommenedMovies();
      print(recommendMovies.length);
      emit(SuccessfulMovieState(movies: recommendMovies));
    } catch (e) {
      emit(ErrorMovieState(errorMessage: e.toString()));
    }
  }
  void getNewlyReleasedMovies() async {
    emit(LoadingMovieState());
    try {
      var movies = await moviesRepository.getNewlyReleasedMovies();
      print(movies.length);
      emit(SuccessfulMovieState(movies: movies));
    } catch (e) {
      emit(ErrorMovieState(errorMessage: e.toString()));
    }
  }

  
}
