import 'package:flutter/material.dart';
import 'package:movies_stage/config/routes/route_generator.dart';
import 'package:movies_stage/config/themes/app_theme.dart';

void main() {
  runApp(const MoviesStage());
}

class MoviesStage extends StatelessWidget {
  const MoviesStage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      initialRoute: '/movies_list',
      themeMode: ThemeMode.light,
      theme: AppTheme.getDefaultTheme(),
    );
  }
}
