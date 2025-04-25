import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_stage/config/routes/app_routes.dart';
import 'package:movies_stage/presentation/movies_list/bloc/fav_movies_bloc.dart';
import 'package:movies_stage/presentation/movies_list/bloc/fav_movies_events.dart';
import 'package:movies_stage/presentation/movies_list/bloc/movie_list_events.dart';
import 'package:movies_stage/presentation/movies_list/bloc/movies_list_bloc.dart';
import 'package:movies_stage/presentation/movies_list/view/movie_card.dart';
import 'package:movies_stage/utils.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    context.read<MoviesListBloc>().add(GetMoviesEvent());
    context.read<FavMoviesBloc>().add(GetFavMoviesEvent());
    _scrollController.addListener(_handleScroll);
    super.initState();
  }

  void _handleScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        context.read<MoviesListBloc>().state is! LoadingMovieState) {
      if (context.read<MoviesListBloc>().state is SwitchToFavState) {
        return;
      }
      context.read<MoviesListBloc>().add(GetMoviesEvent());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {},
      child: BlocBuilder<MoviesListBloc, MovieListState>(
        builder: (context, allMoviesState) {
          return BlocBuilder<FavMoviesBloc, FavMoviesState>(
            builder: (context, favMoviesState) {
              return Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () async {
                    Navigator.of(context).pushNamed(AppRoutes.moviesSearch);
                  },
                  foregroundColor: Colors.white,
                  child: Icon(
                    Icons.search,
                    size: 30,
                  ),
                ),
                appBar: AppBar(
                  title: Text("Movies STAGE"),
                  centerTitle: false,
                  actions: [
                    Transform.scale(
                        scale: 0.7,
                        child: Switch(
                          value: allMoviesState is SwitchToFavState,
                          padding: EdgeInsets.zero,
                          onChanged: (value) {
                            value
                                ? context
                                    .read<MoviesListBloc>()
                                    .add(SwitchToFavEvent())
                                : context
                                    .read<MoviesListBloc>()
                                    .add(GetMoviesEvent());
                          },
                          trackOutlineColor:
                              WidgetStatePropertyAll(Colors.white),
                          thumbColor: WidgetStatePropertyAll(Colors.white),
                          activeTrackColor: Color.fromARGB(255, 255, 180, 174),
                          activeColor: Color.fromARGB(255, 255, 180, 174),
                          inactiveTrackColor: Colors.transparent,
                          // trackColor: WidgetStatePropertyAll(Colors.transparent),
                        )),
                    Icon(
                      Icons.favorite_border,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                  leading: Icon(Icons.sort),
                ),
                body: SizedBox(
                  width: w,
                  height: h,
                  child: allMoviesState is ErrorMoviesState &&
                          allMoviesState.movies.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Opps! Unable to Fetch Movies.",
                              style: TextStyle(color: Colors.grey),
                            ),
                            ElevatedButton.icon(
                                onPressed: () {
                                  context
                                      .read<MoviesListBloc>()
                                      .add(SwitchToFavEvent());
                                },
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.redAccent),
                                icon: Icon(
                                  Icons.favorite_border_outlined,
                                  color: Colors.white,
                                ),
                                label: Text("View Favorites"))
                          ],
                        )
                      : GridView.builder(
                          // cacheExtent: (state.movies.length / 2) * h * 0.1,
                          controller: _scrollController,
                          itemCount: allMoviesState is SwitchToFavState
                              ? favMoviesState.movies.length
                              : allMoviesState.movies.length +
                                  ((allMoviesState is LoadingMovieState) &&
                                          allMoviesState.page > 1
                                      ? 2
                                      : 0),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: h * 0.35,
                                  crossAxisSpacing: 2,
                                  mainAxisSpacing: 2,
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            if (allMoviesState is! SwitchToFavState &&
                                index >= allMoviesState.movies.length) {
                              return getLoader(w: w * 0.4, h: h * 0.2);
                            }
                            return InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(
                                      AppRoutes.movieDetails,
                                      arguments: {
                                        'movie':
                                            allMoviesState is SwitchToFavState
                                                ? favMoviesState.movies[index]
                                                : allMoviesState.movies[index]
                                      });
                                },
                                child: MovieCard(
                                  movie: allMoviesState is SwitchToFavState
                                      ? favMoviesState.movies[index]
                                      : allMoviesState.movies[index],
                                ));
                          }),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
