import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:movies_app/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:movies_app/features/movies/data/repositry/movie_repositry_impl.dart';
import 'package:movies_app/features/movies/domain/entites/movie_model.dart';
import 'package:movies_app/features/movies/domain/repositry/movies_repositry.dart';
import 'package:movies_app/features/movies/domain/usecases/view_recommended_movies.dart';
import 'package:movies_app/support/resources/locators/api_locator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/support/routes_manager/routes.dart';
import 'package:movies_app/support/routes_manager/routes_generator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/authentication/domain/use_cases/login_use_case.dart';
import 'features/authentication/domain/use_cases/logout_use_case.dart';
import 'features/authentication/domain/use_cases/registeration_use_case.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final authRepository = AuthRepositoryImpl();

  final loginUseCase = LoginUseCase(authRepository);
  final registerUseCase = RegisterUseCase(authRepository);
  final logoutUseCase = LogoutUseCase(authRepository);
  runApp(MyApp(
    loginUseCase: loginUseCase,
    registerUseCase: registerUseCase,
    logoutUseCase: logoutUseCase,
  ));
}

class MyApp extends StatelessWidget {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;
  const MyApp(
      {required this.loginUseCase,
      required this.registerUseCase,
      required this.logoutUseCase,
      super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return BlocProvider(
      create: (context) => AuthCubit(
        loginUseCase,
        registerUseCase,
        logoutUseCase,
      ),
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
