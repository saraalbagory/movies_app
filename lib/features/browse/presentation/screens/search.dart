import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/features/browse/presentation/bloc/search/search_cubit.dart';
import 'package:movies_app/features/browse/presentation/widgets/searchResultsWidget.dart';
import 'package:movies_app/support/app_colors.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchCubit = context.read<SearchCubit>();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: TextField(
              controller: controller,
              onChanged: (value) {
                searchCubit.searchMovies(value);
              },
              style: TextStyle(color: Colors.white, fontSize: 20.sp),
              decoration: const InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(
                    Icons.search_rounded,
                  ),
                  iconColor: Colors.white),
            ),
          ),
          Expanded(
            child: SearchResultsWidgets(
              query: controller.text,
            ),
          ),
        ],
      ),
    );
  }
}
