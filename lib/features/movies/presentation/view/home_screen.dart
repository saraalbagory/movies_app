import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/browsing_locators.dart';
import 'package:movies_app/features/browse/presentation/bloc/genres/geners_cubit.dart';
import 'package:movies_app/features/browse/presentation/bloc/search/search_cubit.dart';
import 'package:movies_app/features/movies/presentation/view/widgets/movies_slider.dart';
import 'package:movies_app/features/movies/presentation/view/widgets/movies_list.dart';
import 'package:movies_app/support/app_colors.dart';
import 'package:movies_app/features/browse/presentation/screens/genresScreen.dart';
import 'package:movies_app/features/browse/presentation/screens/search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    Column(
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
              ),
            ],
          ),
        ),
      ],
    ),
    BlocProvider(
      create: (_) => sl<SearchCubit>(),
      child: const Search(),
    ),
    BlocProvider(
      create: (_) => sl<GenresCubit>()..fetchCategories(),
      child: const GenresScreen(),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: _screens[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(12.h),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25.0.r),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              selectedItemColor: AppColors.yellowColor,
              unselectedItemColor: Colors.white,
              backgroundColor: AppColors.backgroundColor,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              elevation: 0,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                  label: 'Movies',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.explore),
                  label: 'Genres',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
