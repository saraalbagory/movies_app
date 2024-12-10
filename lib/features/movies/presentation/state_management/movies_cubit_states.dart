import 'package:equatable/equatable.dart';
import 'package:movies_app/features/movies/domain/entites/movie_model.dart';

abstract class MoviesCubitState extends Equatable {}

class IntialMovieState extends MoviesCubitState {
  @override
  List<Object?> get props => [];
}

class LoadingMovieState extends MoviesCubitState {
  @override
  List<Object?> get props => [];
}

class ErrorMovieState extends MoviesCubitState {
  final String errorMessage;

  ErrorMovieState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class SuccessfulMovieState extends MoviesCubitState {
  List<MovieModel> movies;

  SuccessfulMovieState({required this.movies});
  @override
  List<Object?> get props => movies;
}

// class SuccessfulRecommendedMovieState extends MoviesCubitState {
//   List<MovieModel> movies;

//   SuccessfulRecommendedMovieState({required this.movies});
//   @override
//   List<Object?> get props => movies;
// }

// class SuccessfulNewlyReleasedMovieState extends MoviesCubitState {
//   List<MovieModel> movies;

//   SuccessfulNewlyReleasedMovieState({required this.movies});
//   @override
//   List<Object?> get props => movies;
// }
