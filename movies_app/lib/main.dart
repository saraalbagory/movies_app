import 'package:flutter/material.dart';
import 'package:movies_app/features/movies/data/data_sources/api_movies_sources_impl.dart';
import 'package:movies_app/features/movies/data/repositry/movie_repositry_impl.dart';
import 'package:movies_app/features/movies/domain/entites/movie_model.dart';
import 'package:movies_app/features/movies/domain/repositry/movies_repositry.dart';
import 'package:movies_app/features/movies/domain/usecases/view_newly_released_movies.dart';
import 'package:movies_app/features/movies/domain/usecases/view_popular_movies.dart';
import 'package:movies_app/features/movies/domain/usecases/view_recommended_movies.dart';
import 'package:movies_app/support/resources/locators/api_locator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const  MovieListScreen(title: 'Flutter Demo Home Page'),
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
    ViewRecommendedMovies usecase = ViewRecommendedMovies(repo) ;
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
                    title: Text(movie.title??" "),
                    subtitle: Text(movie.overview?? 'No description available'),
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

