import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/features/movies/presentation/state_management/movies_cubit.dart';
import 'package:movies_app/features/movies/presentation/state_management/movies_cubit_states.dart';
import 'package:movies_app/features/movies/presentation/view/widgets/movie_card.dart';
import 'package:movies_app/main.dart';
import 'package:movies_app/support/app_colors.dart';

class MoviesList extends StatefulWidget {
  final String title;
  final bool newRelease;

  const MoviesList({super.key, required this.title, required this.newRelease});

  @override
  State<MoviesList> createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  late MoviesCubit _moviesCubit;
  @override
  void initState() {
    super.initState();
    _moviesCubit = MoviesCubit();
    if(widget.newRelease){
      _moviesCubit.getNewlyReleasedMovies();
    }
    else{
      _moviesCubit.getRecommendMovies();
    }
    
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
        } else if (state is SuccessfulMovieState) {
          return Container(
            padding: EdgeInsets.all(15.h),
            // height: 221.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.title,
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                    ),
                    const Spacer(),
                    TextButton.icon(
                      iconAlignment: IconAlignment.end,
                      label: Text(
                        "See More",
                        style:
                            TextStyle(color: AppColors.yellowColor, fontSize: 16.sp),
                      ),
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_rounded,
                        color: AppColors.yellowColor,
                        size: 15.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 220.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return MovieCard(
                        impagePath: state.movies[index].posterPath ?? "",
                        height: 220.h,
                        width: 140.w,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(width: 15.w);
                    },
                    itemCount: state.movies.length,
                  ),
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
