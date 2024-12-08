import 'package:flutter/material.dart';
import 'package:movies_app/features/movies/data/data_sources/api_search_result.dart';
import 'package:movies_app/features/movies/data/models/SearchReturnModel.dart';

class SearchResultsWidgets extends StatefulWidget {
  const SearchResultsWidgets({
    super.key,
    required this.query,
    required this.apiSearchResult,
  });

  final String query;
  final ApiSearchResult apiSearchResult;

  @override
  State<SearchResultsWidgets> createState() => _SearchResultsWidgetsState();
}

class _SearchResultsWidgetsState extends State<SearchResultsWidgets> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SearchReturnModel>(
      future: widget.apiSearchResult.getSearchResults(widget.query),
      builder: (context, searchResultsSnapshot) {
        if (searchResultsSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (searchResultsSnapshot.hasError) {
          return Center(
            child: Text("Error: ${searchResultsSnapshot.error}"),
          );
        } else if (searchResultsSnapshot.hasData) {
          // Safely extract the movie list
          final movies = searchResultsSnapshot.data?.results ?? [];

          if (movies.isEmpty) {
            return const Center(
              child: Text("No movies found."),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return Card(
                child: ListTile(
                  leading: movie.posterPath != null
                      ? Image.network(
                          'https://image.tmdb.org/t/p/w92${movie.posterPath}',
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.movie),
                  title: Text(movie.title ?? "No Title"),
                  subtitle: Text(movie.overview ?? "No Description"),
                ),
              );
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
