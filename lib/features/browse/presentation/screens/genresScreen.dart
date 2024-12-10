import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/browsing_locators.dart';
import 'package:movies_app/features/browse/data/models/GenresModel.dart';
import 'package:movies_app/features/browse/presentation/bloc/genre_Movies/genre_movies_cubit.dart';
import 'package:movies_app/features/browse/presentation/bloc/genres/geners_cubit.dart';
import 'package:movies_app/features/browse/presentation/bloc/genres/genres_cubit_states.dart';
import 'package:movies_app/features/browse/presentation/widgets/moviesByGenreWidget.dart';
import 'package:movies_app/support/app_colors.dart';

class GenresScreen extends StatefulWidget {
  const GenresScreen({super.key});

  @override
  _GenresScreenState createState() => _GenresScreenState();
}

class _GenresScreenState extends State<GenresScreen> {
  int selectedGenreId = 0;

  @override
  Widget build(BuildContext context) {
    context.read<GenresCubit>().fetchCategories();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          BlocBuilder<GenresCubit, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CategoriesLoaded) {
                if (selectedGenreId == 0 && state.genres.isNotEmpty) {
                  selectedGenreId = state.genres[0].id!;
                }

                return SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.genres.length,
                    itemBuilder: (context, index) {
                      final genre = state.genres[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedGenreId = genre.id!;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: selectedGenreId == genre.id
                                ? Colors.yellow
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                              genre.name ?? 'Unknown',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (state is CategoriesError) {
                return Center(child: Text(state.message));
              }
              return Container();
            },
          ),
          Expanded(
            child: BlocBuilder<GenresCubit, CategoriesState>(
              builder: (context, state) {
                if (state is CategoriesLoaded) {
                  final selectedGenre = state.genres.firstWhere(
                    (genre) => genre.id == selectedGenreId,
                    orElse: () => Genre(id: -1, name: 'Unknown'),
                  );

                  if (selectedGenre.id == -1) {
                    return const Center(
                      child: Text("Select a genre to see movies"),
                    );
                  } else {
                    return BlocProvider(
                      create: (_) => sl<MoviesByGenreCubit>(),
                      child: MoviesbyGenreWidget(
                        genre: selectedGenre,
                      ),
                    );
                  }
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
