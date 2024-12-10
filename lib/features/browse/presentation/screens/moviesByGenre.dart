import 'package:flutter/material.dart';
import 'package:movies_app/features/browse/data/models/GenresModel.dart';
import 'package:movies_app/features/browse/presentation/bloc/genre_Movies/genre_movies_cubit.dart';
import 'package:movies_app/features/browse/presentation/bloc/genre_Movies/genre_movies_cubit_states.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/movies/presentation/view/widgets/movie_card.dart';

class MoviesbyGenreWidget extends StatelessWidget {
  final Genre genre;
  const MoviesbyGenreWidget({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    context.read<MoviesByGenreCubit>().fetchMoviesByGenre(genre);

    return BlocBuilder<MoviesByGenreCubit, MoviesByGenreState>(
      builder: (context, state) {
        if (state is MoviesByGenreLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MoviesByGenreLoaded) {
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              // crossAxisSpacing: 8.0,
              // mainAxisSpacing: 8.0,
            ),
            itemCount: state.movies.length,
            itemBuilder: (context, index) {
              final movie = state.movies[index];
              return MovieCard(
                movieId: state.movies[index].id.toString(),
                impagePath: movie.backdropPath ?? '',
                height: double.infinity,
                width: double.infinity,
              );
            },
          );
        } else if (state is MoviesByGenreError) {
          return Center(child: Text(state.message));
        }
        return const Center(child: Text("Something went wrong"));
      },
    );
  }
}
