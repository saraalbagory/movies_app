import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/features/movies/presentation/state_management/movies_cubit.dart';
import 'package:movies_app/features/movies/presentation/state_management/movies_cubit_states.dart';
import 'package:movies_app/features/movies/presentation/view/widgets/movie_card.dart';
import 'package:movies_app/support/resources/api_info/api_consts.dart';

class PopularMoviesSlider extends StatefulWidget {
  const PopularMoviesSlider({super.key});

  @override
  State<PopularMoviesSlider> createState() => _PopularMoviesSliderState();
}

class _PopularMoviesSliderState extends State<PopularMoviesSlider> {
  late MoviesCubit moviesCubit;
  int displayedImageIndex = 1;
  @override
  void initState() {
    super.initState();
    moviesCubit = MoviesCubit();
    moviesCubit.getPopularMovies();
  }
  // void didUpdateWidget(covariant HomeScreen oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   moviesCubit.getPopularMovies();
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 645.h,
        child: BlocProvider(
          create: (context) => moviesCubit,
          child: BlocBuilder<MoviesCubit, MoviesCubitState>(
            builder: (context, state) {
              if (state is LoadingMovieState) {
                return const CircularProgressIndicator();
              } else if (state is ErrorMovieState) {
                return Text(state.errorMessage);
              } else if (state is SuccessfulMovieState) {
                return Stack(children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(ApiConsts.imageBaseUrl +
                            ApiConsts.backdropSize +
                            state.movies[displayedImageIndex]
                                .backdropPath!), // Replace with your image URL or AssetImage
                        fit: BoxFit.cover, // Adjust image fit
                      ),
                    ),
                    child: Container(
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
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/AvailableNow.png",
                        height: 140.h,
                        width: 354.w,
                      ),
                      CarouselSlider.builder(
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) {
                          return MovieCard(
                              impagePath: state.movies[index].posterPath ?? "", height: 350.h, width: 234.w,);
                        },
                        itemCount: state.movies.length,
                        options: CarouselOptions(
                          height: 360.h,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction:
                              0.6, // Ensures cards on the side are partially visible
                          aspectRatio: 2.0,
                          initialPage: 1,
                          autoPlayAnimationDuration:
                              const Duration(seconds: 10),
                          autoPlayCurve: Curves.bounceInOut,
                          onPageChanged: (index, reason) {
                            setState(() {
                              displayedImageIndex = index;
                            });
                          },
                        ),
                      ),
                      Image.asset(
                        "assets/images/WatchNow.png",
                        height: 140.h,
                        width: 354.w,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ]);
              } else {
                return const SizedBox();
              }
            },
          ),
        ));
  }
}
