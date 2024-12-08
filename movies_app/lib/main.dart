import 'package:flutter/material.dart';
import 'package:movies_app/features/browse/data/data_sources/api_genres_get_impl.dart';
import 'package:movies_app/features/browse/data/data_sources/api_movies_by_genre_impl.dart';
import 'package:movies_app/features/browse/data/data_sources/api_search_result.dart';
import 'package:movies_app/features/browse/data/data_sources/api_search_results_impl.dart';
import 'package:movies_app/features/browse/data/repository/genres_repo_impl.dart';
import 'package:movies_app/features/browse/data/repository/movies_by_genre_repo_impl.dart';
import 'package:movies_app/features/browse/data/repository/search_movies_repo_impl.dart';
import 'package:movies_app/features/browse/domain/repositoy/movies_by_genre_repo.dart';
import 'package:movies_app/features/browse/domain/usecases/search_by_name.dart';
import 'package:movies_app/features/browse/domain/usecases/view_genres.dart';
import 'package:movies_app/features/browse/domain/usecases/view_movies_by_genre.dart';
import 'package:movies_app/features/browse/presentation/bloc/genre_Movies/genre_movies_cubit.dart';
import 'package:movies_app/features/browse/presentation/bloc/genres/geners_cubit.dart';
import 'package:movies_app/features/browse/presentation/bloc/search/search_cubit.dart';
import 'package:movies_app/features/movies/data/data_sources/api_movies_sources_impl.dart';
import 'package:movies_app/features/movies/data/repositry/movie_repositry_impl.dart';
import 'package:movies_app/features/movies/domain/entites/movie_model.dart';
import 'package:movies_app/features/movies/domain/repositry/movies_repositry.dart';
import 'package:movies_app/features/movies/domain/usecases/view_newly_released_movies.dart';
import 'package:movies_app/features/movies/domain/usecases/view_popular_movies.dart';
import 'package:movies_app/features/movies/domain/usecases/view_recommended_movies.dart';
import 'package:movies_app/features/movies/presentation/view/home_screen.dart';
import 'package:movies_app/features/movies/presentation/view/widgets/movies_slider.dart';
import 'package:movies_app/support/resources/locators/api_locator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  ApiGenresGetImpl apiGenresGetImpl = new ApiGenresGetImpl();
  ApiSearchResultsImpl apiSearchResultsImpl = new ApiSearchResultsImpl();
  ApiMoviesByGenreImpl apiMoviesByGenreImpl = new ApiMoviesByGenreImpl();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SearchCubit(
              SearchByName(SearchMoviesRepoImpl(apiSearchResultsImpl))),
        ),
        BlocProvider(
          create: (_) =>
              GenresCubit(ViewGenres(GenresRepoImpl(apiGenresGetImpl))),
        ),
        BlocProvider(
          create: (_) => MoviesByGenreCubit(
              ViewMoviesByGenre(MoviesByGenreRepoImpl(apiMoviesByGenreImpl))),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: const HomeScreen(),
    );
  }
}

class MovieListScreen extends StatefulWidget {
  final String title;

  const MovieListScreen({required this.title, Key? key}) : super(key: key);

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Initialize dependencies
    MoviesRepository repo = MovieRepositoryImpl(ApiLocator.apiDataSource);
    ViewRecommendedMovies usecase = ViewRecommendedMovies(repo);
    Future<List<MovieModel>> moviesFuture = usecase();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<List<MovieModel>>(
          future: moviesFuture,
          builder: (context, snapshot) {
            // Handle loading state
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            // Handle error state
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            // Handle successful state
            if (snapshot.hasData) {
              final movies = snapshot.data!;
              return ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return ListTile(
                    title: Text(movie.title ?? " "),
                    subtitle:
                        Text(movie.overview ?? 'No description available'),
                  );
                },
              );
            }

            // Handle case when no data is available
            return const Text('No movies found.');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
