import 'package:flutter/material.dart';
import 'package:movies_app/features/browse/data/data_sources/api_genres_get.dart';
import 'package:movies_app/features/browse/data/data_sources/api_genres_get_impl.dart';
import 'package:movies_app/features/browse/data/models/GenresModel.dart';
import 'package:movies_app/features/browse/presentation/widgets/genreCard.dart';

class GenresView extends StatelessWidget {
  GenresView({super.key /*, required this.apiGenresGet*/});
//to be changed
  final ApiGenresGet apiGenresGet = new ApiGenresGetImpl();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Genres>(
      future: apiGenresGet.getAllGenres(),
      builder: (context, genresSnapshot) {
        if (genresSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (genresSnapshot.hasError) {
          return Center(
            child: Text("Error: ${genresSnapshot.error}"),
          );
        } else if (genresSnapshot.hasData) {
          // Safely extract the genre list
          final genres = genresSnapshot.data?.genres ?? [];

          if (genres.isEmpty) {
            return const Center(
              child: Text("No Genres found."),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: genres.length,
            itemBuilder: (context, index) {
              final genre = genres[index];
              return GenreCard(genre: genre);
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
