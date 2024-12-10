import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:movies_app/features/movies/data/repositry/movie_repositry_impl.dart';
import 'package:movies_app/features/movies/domain/entites/movie_model.dart';
import 'package:movies_app/features/movies/domain/repositry/movies_repositry.dart';
import 'package:movies_app/features/movies/domain/usecases/view_similar_movies.dart';
import 'package:movies_app/support/resources/locators/api_locator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/browsing_locators.dart';
import 'package:movies_app/support/routes_manager/routes.dart';
import 'package:movies_app/support/routes_manager/routes_generator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  browsingSetupLocator();
  runApp(MyApp());

  // Setup dependencies
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: child,
            onGenerateRoute: RoutesGenerator.getRoute,
            initialRoute: Routes.loginRoute,
          );
        },
        //child: const HomeScreen(),
      ),
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
    ViewSimilarMovies usecase = ViewSimilarMovies(repo);
    Future<List<MovieModel>> moviesFuture = usecase("912649");
    //   MovieDetailsDataSource movieDetailsDataSource =
    //   MovieDetailsDataSourceImpl();
    // MoviesDetailsRepositry moviesDetailsRepositry =
    //   MovieDetailsRepoImpl(movieDetailsDataSource);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child:
            // Text(moviesDetailsRepositry.fetchMovieDetails("912649").toString()),
            FutureBuilder<List<MovieModel>>(
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
