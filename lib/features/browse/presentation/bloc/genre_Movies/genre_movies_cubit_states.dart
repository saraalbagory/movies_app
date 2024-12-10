import 'package:movies_app/features/browse/data/models/moviesByGenre.dart';

abstract class MoviesByGenreState {}

class MoviesByGenreLoading extends MoviesByGenreState {}

class MoviesByGenreLoaded extends MoviesByGenreState {
  final List<Results> movies;

  MoviesByGenreLoaded(this.movies);
}

class MoviesByGenreError extends MoviesByGenreState {
  final String message;

  MoviesByGenreError(this.message);
}
