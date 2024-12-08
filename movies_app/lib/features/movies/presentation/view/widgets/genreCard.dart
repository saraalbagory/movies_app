import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movies_app/features/movies/data/models/GenresModel.dart';
import 'package:movies_app/features/movies/presentation/view/moviesByGenre.dart';

class GenreCard extends StatelessWidget {
  const GenreCard({super.key, required this.genre});
  final Genre genre;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MoviesbyGenre(
                        genre: genre,
                      )));
        },
        child: Card(
          child: ListTile(
            leading: const Icon(Icons.category), // Placeholder icon
            title: Text(genre.name ?? "No Name"),
            subtitle: Text("Genre ID: ${genre.id}"),
          ),
        ));
  }
}
