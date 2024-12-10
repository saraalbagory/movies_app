import 'package:flutter/material.dart';
import 'package:movies_app/features/movies/presentation/view/widgets/movies_list.dart';
import 'package:movies_app/features/movies/presentation/view/widgets/movies_slider.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              const PopularMoviesSlider(),
              MoviesList(
                title: 'Recommended',
                type: ListTypes.recommended,
              ),
              MoviesList(
                title: 'New Release',
                type: ListTypes.newRelease,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
