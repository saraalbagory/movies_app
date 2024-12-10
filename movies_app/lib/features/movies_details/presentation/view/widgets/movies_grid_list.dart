import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/features/movies/presentation/state_management/movies_cubit.dart';
import 'package:movies_app/features/movies/presentation/state_management/movies_cubit_states.dart';
import 'package:movies_app/features/movies/presentation/view/widgets/movie_card.dart';
import 'package:movies_app/features/movies/presentation/view/widgets/movies_list.dart';
import 'package:movies_app/main.dart';
import 'package:movies_app/support/app_colors.dart';

class MoviesGridList extends StatefulWidget {
  final String title;
  final ListTypes type;
  String? movieId;
  MoviesGridList(
      {super.key, required this.title, required this.type, this.movieId});

  @override
  State<MoviesGridList> createState() => _MoviesGridListState();
}

class _MoviesGridListState extends State<MoviesGridList> {
  late MoviesCubit _moviesCubit;
  @override
  void initState() {
    super.initState();
    _moviesCubit = MoviesCubit();
    if (widget.type == ListTypes.newRelease) {
      _moviesCubit.getNewlyReleasedMovies();
    } else if (widget.type == ListTypes.recommended) {
      _moviesCubit.getRecommendMovies();
    } else if (widget.type == ListTypes.similar) {
      _moviesCubit.getSimilarMovies(widget.movieId ?? "");
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.title,
                      style: TextStyle(color: Colors.white, fontSize: 24.sp,fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    iconAlignment: IconAlignment.end,
                    label: Text(
                      "See More",
                      style:
                          TextStyle(color: AppColors.yellow, fontSize: 24.sp),
                    ),
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_rounded,
                      color: AppColors.yellow,
                      size: 15.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 610.h, // Total height for the grid
                width: 399.w, // Total width for the grid
                child: GridView.builder(
                  scrollDirection: Axis.horizontal, // Horizontal scrolling
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 3.0,
                    crossAxisSpacing: 3.0,
                    childAspectRatio: 399 / (610 / 2.3),
                  ),
                  itemCount: state.movies.length,
                  itemBuilder: (context, index) {
                    return MovieCard(
                      impagePath: state.movies[index].posterPath ?? "",
                      height: 280.h,
                      width: 190.w,
                      movieId: state.movies[index].id.toString(),
                    );
                  },
                ),
              ),
            ]),
          );
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
