import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/features/browse/presentation/bloc/search/search_cubit.dart';
import 'package:movies_app/features/browse/presentation/bloc/search/search_cubit_states.dart';
import 'package:movies_app/features/movies/presentation/view/widgets/movie_card.dart';

class SearchResultsWidgets extends StatefulWidget {
  const SearchResultsWidgets({
    super.key,
    required this.query,
  });

  final String query;

  @override
  State<SearchResultsWidgets> createState() => _SearchResultsWidgetsState();
}

class _SearchResultsWidgetsState extends State<SearchResultsWidgets> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state is SearchInitial) {
            return Center(child: Text("Enter a query to search"));
          } else if (state is SearchLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SearchLoaded) {
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
          } else if (state is SearchError) {
            return Center(child: Text(state.message));
          }
          return SizedBox();
        },
      ),
    );
  }
}
