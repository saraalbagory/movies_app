import 'package:flutter/material.dart';
import 'package:movies_app/features/authentication/presentation/view/login_screen.dart';
import 'package:movies_app/features/authentication/presentation/view/register_screen.dart';
import 'package:movies_app/features/movies_details/presentation/view/screens/movie_details_screen.dart';
import 'package:movies_app/features/watchList/presentation/view/watchlist_screen.dart';
import 'package:movies_app/features/movies/presentation/view/home_screen.dart';
import 'package:movies_app/support/routes_manager/routes.dart';

class RoutesGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.signUpRoute:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case Routes.watchListRoute:
        return MaterialPageRoute(builder: (_) => const WatchlistScreen());

      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case Routes.movieDetails:
        return MaterialPageRoute(builder: (_) => MovieDetailsScreen(movieId:settings.arguments as String));

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body:  Center(child: Text('No Route Found')),
      ),
    );
  }
}