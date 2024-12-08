import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/features/movies/presentation/state_management/movies_cubit.dart';
import 'package:movies_app/features/movies/presentation/state_management/movies_cubit_states.dart';
import 'package:movies_app/features/movies/presentation/view/widgets/movie_card.dart';
import 'package:movies_app/main.dart';

class RecommendMoviesList extends StatefulWidget {
  const RecommendMoviesList({super.key});

  @override
  State<RecommendMoviesList> createState() => _RecommendMoviesListState();
}

class _RecommendMoviesListState extends State<RecommendMoviesList> {
  late MoviesCubit _moviesCubit;
  @override
  void initState() {
    super.initState();
    _moviesCubit = MoviesCubit();
    _moviesCubit.getRecommendMovies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _moviesCubit,
      child:
          BlocBuilder<MoviesCubit, MoviesCubitState>(builder: (context, state) {
        if (state is LoadingMovieState) {
          return const CircularProgressIndicator();
        } else if (state is ErrorMovieState) {
          return Text(state.errorMessage);
        } else if (state is SuccessfulRecommendedMovieState) {
          return SizedBox(
            child: Column(
              children: [Text("Recommended",style: TextStyle(color: Colors.white,fontSize: 16.sp),),
                ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return MovieCard(
                        impagePath: state.movies[index].posterPath ?? "", height: 220.h, width: 140.w,);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(width: 15.w);
                  },
                  itemCount: state.movies.length,
                ),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
