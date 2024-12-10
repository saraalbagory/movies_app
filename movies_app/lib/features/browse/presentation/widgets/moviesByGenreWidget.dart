import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/features/browse/data/models/GenresModel.dart';
import 'package:movies_app/features/browse/presentation/bloc/genre_Movies/genre_movies_cubit.dart';
import 'package:movies_app/features/browse/presentation/bloc/genre_Movies/genre_movies_cubit_states.dart';
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
        } else if (state is MoviesByGenreError) {
          return Center(child: Text("Error: ${state.message}"));
        } else if (state is MoviesByGenreLoaded) {
          final movies = state.movies;

          if (movies.isEmpty) {
            return const Center(child: Text("No Movies found."));
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return MovieCard(
                impagePath: movie.backdropPath ?? '',
                height: 200.h,
                width: 100.w,
                movieId: state.movies[index].id.toString(),
              );
            },
          );
        }
        return const Center(child: Text("Something went wrong."));
      },
    );
  }
}
