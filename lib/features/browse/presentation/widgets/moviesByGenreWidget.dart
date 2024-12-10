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
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: GridView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20.w,
                mainAxisSpacing: 25.h,
              ),
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return MovieCard(
                  movieId: state.movies[index].id.toString(),
                  impagePath: movie.backdropPath ?? '',
                  height: 400.h,
                  width: 300.w,
                );
              },
            ),
          );
        }
        return const Center(child: Text("Something went wrong."));
      },
    );
  }
}
