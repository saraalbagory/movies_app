import 'package:movies_app/features/movies_details/domain/entites/movie_details_model.dart';

abstract class MovieDetailsCubitStates {}

class IntialState extends MovieDetailsCubitStates{}

class LoadingMovieDetailsState extends MovieDetailsCubitStates{}

class ErrorState extends MovieDetailsCubitStates{
  final String errorMessage;
  ErrorState({ required this.errorMessage});
}

class SucessfulfetchingMovieDetailsState extends MovieDetailsCubitStates{
  MovieDetailsModel movieDetailsModel;
  SucessfulfetchingMovieDetailsState({required this.movieDetailsModel});
}