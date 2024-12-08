import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:movies_app/features/movies/presentation/view/widgets/movies_slider.dart';
import 'package:movies_app/features/movies/presentation/view/widgets/movies_list.dart';
import 'package:movies_app/support/app_colors.dart';
import 'package:movies_app/features/movies/presentation/state_management/movies_cubit.dart';
import 'package:movies_app/features/movies/presentation/state_management/movies_cubit_states.dart';
import 'package:movies_app/features/movies/presentation/view/genresScreen.dart';
import 'package:movies_app/features/movies/presentation/view/search.dart';
import 'package:movies_app/features/movies/presentation/view/widgets/movie_card.dart';


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
              children: const [
                PopularMoviesSlider(),
                MoviesList(
                  title: 'Recommended',
                  newRelease: false,
                ),
                MoviesList(
                  title: 'New Release',
                  newRelease: true,
                )
              ],
            ),
          ),
        ],
      ),
    );

        //to be modif
  }
}
