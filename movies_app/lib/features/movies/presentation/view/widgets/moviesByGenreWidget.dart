import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/features/movies/data/data_sources/api_movies_by_genre.dart';
import 'package:movies_app/features/movies/data/data_sources/api_movies_by_genre_impl.dart';
import 'package:movies_app/features/movies/data/models/GenresModel.dart';
import 'package:movies_app/features/movies/data/models/moviesByGenre.dart';
import 'package:movies_app/features/movies/presentation/view/home_screen.dart';
import 'package:movies_app/features/movies/presentation/view/widgets/movie_card.dart';

class MoviesbyGenreWidget extends StatelessWidget {
  MoviesbyGenreWidget({super.key, required this.genre});
  final Genre genre;
  final ApiMoviesByGenre apiMoviesByGenre = ApiMoviesByGenreImpl();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MoviesByGenre>(
      future: apiMoviesByGenre.getMoviesByGenre(genre),
      builder: (context, moviesByGenresSnapshot) {
        if (moviesByGenresSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (moviesByGenresSnapshot.hasError) {
          return Center(
            child: Text("Error: ${moviesByGenresSnapshot.error}"),
          );
        } else if (moviesByGenresSnapshot.hasData) {
          // Safely extract the genre list
          final movies = moviesByGenresSnapshot.data?.results ?? [];

          if (movies.isEmpty) {
            return const Center(
              child: Text("No Movies found."),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return MovieCard(
                  impagePath: movie.backdropPath ?? '',
                  height: 100.h,
                  width: 80.w);
            },
          );
        }
        return const Center(
          child: Text("Something went wrong."),
        );
      },
    );
  }
}
