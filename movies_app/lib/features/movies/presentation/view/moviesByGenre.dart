import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movies_app/features/movies/data/models/GenresModel.dart';
import 'package:movies_app/features/movies/presentation/view/widgets/moviesByGenreWidget.dart';

class MoviesbyGenre extends StatelessWidget {
  const MoviesbyGenre({super.key, required this.genre});
  final Genre genre;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(genre.name.toString()),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Column(
        children: [MoviesbyGenreWidget(genre: genre)],
      ),
    );
  }
}
