import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/features/movies/presentation/view/widgets/movies_slider.dart';
import 'package:movies_app/features/movies/presentation/view/widgets/recommened_movies_list.dart';
import 'package:movies_app/support/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: const [PopularMoviesSlider(),RecommendMoviesList()],
              
            ),
          ),
        ],
      ),
    );
  }
}