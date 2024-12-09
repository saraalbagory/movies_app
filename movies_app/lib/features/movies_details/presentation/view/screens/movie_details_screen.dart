import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/features/movies_details/presentation/state_managment(cubit)/movie_details_cubit.dart';
import 'package:movies_app/features/movies_details/presentation/state_managment(cubit)/movie_details_cubit_states.dart';
import 'package:movies_app/main.dart';
import 'package:movies_app/support/app_colors.dart';
import 'package:movies_app/support/resources/api_info/api_consts.dart';

class MovieDetailsScreen extends StatefulWidget {
  final String movieId;

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late MovieDetailsCubit _detailsCubit;
  @override
  void initState() {
    super.initState();
    _detailsCubit = MovieDetailsCubit();
    _detailsCubit.getMovieDetails(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   actions: [
      //     IconButton(onPressed: () {}, icon: Icon(Icons.bookmark,size: 29.sp,color: Colors.white,))
      //   ],
      // ),
      body: BlocProvider(
        create: (BuildContext context) => _detailsCubit,
        child: BlocBuilder<MovieDetailsCubit, MovieDetailsCubitStates>(
            builder: (context, state) {
          if (state is LoadingMovieDetailsState) {
            return const CircularProgressIndicator();
          } else if (state is ErrorState) {
            return Text(state.errorMessage);
          } else if (state is SucessfulfetchingMovieDetailsState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 766.h,
                        width: 430.w,
                        child: Image.network(
                          ApiConsts.imageBaseUrl +
                              ApiConsts.imagesSize +
                              state.movieDetailsModel.posterPath!,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        height: 766.h,
                        width: 430.w,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(
                                  18, 19, 18, 0.8), // rgba(18, 19, 18, 0.8)
                              Color.fromRGBO(
                                  18, 19, 18, 0.6), // rgba(18, 19, 18, 0.6)
                              Color(0xFF121312), // #121312
                            ],
                            stops: [
                              0.0,
                              0.465,
                              1.0
                            ], // Corresponds to CSS percentage stops
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [SizedBox(
                            height:28.h,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 12.w,
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.arrow_back_ios_rounded,
                                    color: Colors.white,
                                    size: 29.sp,
                                    weight: 600,
                                  )),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.bookmark_rounded,
                                    color: Colors.white,
                                    size: 29.sp,
                                    weight: 600,
                                  )),
                              SizedBox(
                                width: 10.w,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 240.h,
                          ),
                          IconButton.filled(
                              onPressed: () {},
                              style: IconButton.styleFrom(
                                backgroundColor: AppColors.yellow,
                                foregroundColor: Colors.white,
                              ),
                              focusColor: AppColors.yellow,
                              iconSize: 50.sp,
                              padding: EdgeInsets.all(20.w),
                              icon: const Icon(
                                Icons.play_arrow_rounded,
                                color: Colors.white,
                                weight: 600,
                              )),
                          SizedBox(
                            height: 240.h,
                          ),
                          Text(
                            state.movieDetailsModel.tagline!,
                            style: TextStyle(
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          Text(
                            state.movieDetailsModel.releaseDate!,
                            style: TextStyle(
                                fontSize: 26.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textGrey),
                          )
                        ],
                      )
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          Color(0xffE82626)), // Background color
                      foregroundColor:
                          WidgetStateProperty.all(Colors.white), // Text color
                      padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 165.w, vertical: 24.h),
                      ), // Padding
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15), // Rounded corners
                        ),
                      ),
                    ),
                    child: Text(
                      "Watch",
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                  Row(
                    children: [Container(
                      width: 122.w,
                      height: 47.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.transparentBlack,
                      ),
                      child: Row(
                        children: [ImageIcon(),],
                      ),
                    )],
                  )
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        }),
      ),
    );
  }
}
