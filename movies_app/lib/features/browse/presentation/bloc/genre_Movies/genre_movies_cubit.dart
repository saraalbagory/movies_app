import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/browse/data/models/GenresModel.dart';
import 'package:movies_app/features/browse/domain/usecases/view_movies_by_genre.dart';
import 'package:movies_app/features/browse/presentation/bloc/genre_Movies/genre_movies_cubit_states.dart';

class MoviesByGenreCubit extends Cubit<MoviesByGenreState> {
  final ViewMoviesByGenre viewMoviesByGenreUseCase;
  MoviesByGenreCubit(this.viewMoviesByGenreUseCase)
      : super(MoviesByGenreLoading());

  void fetchMoviesByGenre(Genre genre) async {
    try {
      final movies = await viewMoviesByGenreUseCase.call(genre);
      emit(MoviesByGenreLoaded(movies));
    } catch (e) {
      emit(MoviesByGenreError(e.toString()));
    }
  }
}
