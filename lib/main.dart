import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_stage/config/routes/route_generator.dart';
import 'package:movies_stage/config/themes/app_theme.dart';
import 'package:movies_stage/data/local/local_data_provider.dart';
import 'package:movies_stage/presentation/movies_list/bloc/fav_movies_bloc.dart';
import 'package:movies_stage/presentation/movies_list/bloc/movies_list_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDataProvider().initIsar();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<MoviesListBloc>(create: (_) => MoviesListBloc()),
    BlocProvider<FavMoviesBloc>(create: (_) => FavMoviesBloc())
  ], child: MoviesStage()));
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
