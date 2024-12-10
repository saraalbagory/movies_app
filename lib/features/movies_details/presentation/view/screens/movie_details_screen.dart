import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/features/movies/presentation/view/widgets/movies_list.dart';
import 'package:movies_app/features/movies_details/presentation/state_managment(cubit)/movie_details_cubit.dart';
import 'package:movies_app/features/movies_details/presentation/state_managment(cubit)/movie_details_cubit_states.dart';
import 'package:movies_app/features/movies_details/presentation/view/widgets/movies_grid_list.dart';
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        children: [
                          SizedBox(
                            height: 28.h,
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
                                backgroundColor: AppColors.yellowColor,
                                foregroundColor: Colors.white,
                              ),
                              focusColor: AppColors.yellowColor,
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
                            returnYear(state.movieDetailsModel.releaseDate!),
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
                          const Color(0xffE82626)), // Background color
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
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 122.w,
                        height: 49.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.grayColor,
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ImageIcon(
                                  const AssetImage("assets/images/heart.png"),
                                  color: AppColors.yellowColor),
                              Text(state.movieDetailsModel.voteCount.toString(),
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white)),
                            ]),
                      ),
                      Container(
                        width: 122.w,
                        height: 49.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.grayColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ImageIcon(
                              const AssetImage("assets/images/clock.png"),
                              color: AppColors.yellowColor,
                            ),
                            Text(state.movieDetailsModel.runtime.toString(),
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white))
                          ],
                        ),
                      ),
                      Container(
                        width: 122.w,
                        height: 49.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.textGrey,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ImageIcon(
                              const AssetImage("assets/images/star.png"),
                              color: AppColors.yellowColor,
                            ),
                            Text(state.movieDetailsModel.voteAverage.toString(),
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white))
                          ],
                        ),
                      )
                    ],
                  ),
                  MoviesGridList(
                    title: "Similar",
                    type: ListTypes.similar,
                    movieId: state.movieDetailsModel.id.toString(),
                  ),
                  Container(
                    height: 275.h,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Summary",
                            style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white)),
                        Text(state.movieDetailsModel.overview ?? "",
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white))
                      ],
                    ),
                  ),
                  Container(
                    height: 132.h,
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Genres",
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white
                            )),
                        SizedBox(height: 10,),
                        Expanded(
                          child: Wrap(
                            spacing: 8.0, // Horizontal space between items
                            runSpacing: 8.0, // Vertical space between rows
                            children: List.generate(
                              state.movieDetailsModel.genres?.length ?? 0,
                              (genreIndex) {
                                return Container(
                                  width: 122.w,
                                  height: 36.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: AppColors.textGrey,
                                  ),
                                  child: Center(
                                    child: Text(
                                      state.movieDetailsModel
                                              .genres?[genreIndex].name ??
                                          "",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
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

String returnYear(String dateString) {
  DateTime date = DateTime.parse(dateString);

  int year = date.year;

  return year.toString();
}
