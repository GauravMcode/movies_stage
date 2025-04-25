import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_stage/config/routes/app_routes.dart';
import 'package:movies_stage/presentation/movie_search/bloc/search_movie_event.dart';
import 'package:movies_stage/presentation/movie_search/bloc/search_movies_bloc.dart';
import 'package:movies_stage/presentation/movies_list/view/movie_card.dart';

class MoviesSearch extends StatefulWidget {
  const MoviesSearch({super.key});

  @override
  State<MoviesSearch> createState() => _MoviesSearchState();
}

class _MoviesSearchState extends State<MoviesSearch> {
  @override
  void initState() {
    focusNode.requestFocus();
    super.initState();
  }

  final focusNode = FocusNode();
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return BlocBuilder<SearchMoviesBloc, SearchMovieState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leadingWidth: 0,
            centerTitle: true,
            titleSpacing: 0,
            title: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: Colors.white),
              width: w * 0.8,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                focusNode: focusNode,
                controller: searchController,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  context
                      .read<SearchMoviesBloc>()
                      .add(GetSearchMoviesEvent(value));
                },
                style: TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                  hintText: "Search for Movies",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          body: SizedBox(
            width: w,
            height: h,
            child: (state is FetchedSearchedMovieState ||
                        state is InitialSearchMovieState) &&
                    state.movies.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        searchController.text.isEmpty
                            ? "Type to Search for Movies"
                            : "No matching movies found",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  )
                : GridView.builder(
                    itemCount: state.movies.length,
                    gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: h * 0.35,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              AppRoutes.movieDetails,
                              arguments: {'movie': state.movies[index]});
                        },
                        child: MovieCard(
                          movie: state.movies[index],
                        ),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}
