import 'package:flutter/material.dart';
import 'package:movies_stage/config/routes/route_error_page.dart';
import 'package:movies_stage/presentation/movie_details/view/movie_details.dart';
import 'package:movies_stage/presentation/movies_list/view/movie_list.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/movies_list':
        return MaterialPageRoute(builder: (_) => MovieList());
      case '/movie_details':
        return MaterialPageRoute(builder: (_) => MovieDetails());
      default:
        return MaterialPageRoute(builder: (_) => RouteErrorPage());
    }
  }
}
