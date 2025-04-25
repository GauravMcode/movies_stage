import 'package:flutter/material.dart';
import 'package:movies_stage/config/routes/app_routes.dart';
import 'package:movies_stage/config/routes/route_error_page.dart';
import 'package:movies_stage/presentation/movie_details/view/movie_details.dart';
import 'package:movies_stage/presentation/movie_search/view/movies_search.dart';
import 'package:movies_stage/presentation/movies_list/view/movie_list.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case AppRoutes.moviesList:
        return MaterialPageRoute(builder: (_) => MovieList());
      case AppRoutes.movieDetails:
        return MaterialPageRoute(builder: (_) => MovieDetails());
      case AppRoutes.moviesSearch:
        return MaterialPageRoute(builder: (_) => MoviesSearch());
      default:
        return MaterialPageRoute(builder: (_) => RouteErrorPage());
    }
  }
}
