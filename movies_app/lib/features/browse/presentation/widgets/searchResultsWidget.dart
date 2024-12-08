import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/browse/presentation/bloc/search/search_cubit.dart';
import 'package:movies_app/features/browse/presentation/bloc/search/search_cubit_states.dart';

class SearchResultsWidgets extends StatefulWidget {
  const SearchResultsWidgets({
    super.key,
    required this.query,
    //required this.apiSearchResult,
  });

  final String query;
  //final ApiSearchResult apiSearchResult;

  @override
  State<SearchResultsWidgets> createState() => _SearchResultsWidgetsState();
}

class _SearchResultsWidgetsState extends State<SearchResultsWidgets> {
  @override
  Widget build(BuildContext context) {
    // return FutureBuilder<SearchReturnModel>(
    //   future: widget.apiSearchResult.getSearchResults(widget.query),
    //   builder: (context, searchResultsSnapshot) {
    //     if (searchResultsSnapshot.connectionState == ConnectionState.waiting) {
    //       return const Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     } else if (searchResultsSnapshot.hasError) {
    //       return Center(
    //         child: Text("Error: ${searchResultsSnapshot.error}"),
    //       );
    //     } else if (searchResultsSnapshot.hasData) {
    //       // Safely extract the movie list
    //       final movies = searchResultsSnapshot.data?.results ?? [];

    //       if (movies.isEmpty) {
    //         return const Center(
    //           child: Text("No movies found."),
    //         );
    //       }

    return Expanded(
      // child: SearchResultsWidgets(
      //   query: controller.text,
      //   apiSearchResult: apiSearchResult,
      // ),
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state is SearchInitial) {
            return Center(child: Text("Enter a query to search"));
          } else if (state is SearchLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SearchLoaded) {
            return ListView.builder(
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                final movie = state.movies[index];
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
          } else if (state is SearchError) {
            return Center(child: Text(state.message));
          }
          return SizedBox();
        },
      ),
    );
  }
  //       return const Center(
  //         child: Text("Something went wrong."),
  //       );
  //     },
  //   );
  // }
}
