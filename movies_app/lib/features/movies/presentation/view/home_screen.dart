import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  late MoviesCubit moviesCubit;
  @override
  void initState() {
    super.initState();
    moviesCubit = MoviesCubit();
    moviesCubit.getPopularMovies();
  }
  // void didUpdateWidget(covariant HomeScreen oldWidget) {
  //   // TODO: implement didUpdateWidget
  //   super.didUpdateWidget(oldWidget);
  //   moviesCubit.getPopularMovies();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //to be modified
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          //title: Text(widget.title),
          //to be removed, just for testing
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Search()));
                },
                icon: const Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GenresScreen()));
                },
                icon: const Icon(Icons.list))
          ],
        ),
        body: BlocProvider(
          create: (context) => moviesCubit,
          child: BlocBuilder<MoviesCubit, MoviesCubitState>(
            builder: (context, state) {
              if (state is LoadingMovieState) {
                return const CircularProgressIndicator();
              } else if (state is ErrorMovieState) {
                return Text(state.errorMessage);
              } else if (state is SuccessfulMovieState) {
                return SizedBox(
                  height: 930.h,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return MovieCard(
                          impagePath: state.movies[index].posterPath ?? "");
                    },
                    itemCount: state.movies.length,
                  ),
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ));
  }
}
