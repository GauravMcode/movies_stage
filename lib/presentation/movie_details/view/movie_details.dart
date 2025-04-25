import 'dart:convert';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:movies_stage/config/widget_keys.dart';
import 'package:movies_stage/domain/models/movie.dart';
import 'package:movies_stage/presentation/movies_list/bloc/fav_movies_bloc.dart';
import 'package:movies_stage/presentation/movies_list/bloc/fav_movies_events.dart';
import 'package:movies_stage/presentation/movies_list/bloc/movie_list_events.dart';
import 'package:movies_stage/presentation/movies_list/bloc/movies_list_bloc.dart';
import 'package:movies_stage/utils.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({super.key, required this.movie});
  final Movie movie;

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: SafeArea(
        child: Container(
            color: Colors.white,
            width: w,
            height: h,
            child: Stack(
              children: [
                ListView(
                  children: [
                    BlocBuilder<MoviesListBloc, MovieListState>(
                      builder: (context, allMoviesState) {
                        return BlocBuilder<FavMoviesBloc, FavMoviesState>(
                          builder: (context, state) {
                            return allMoviesState is SwitchToFavState
                                ? Builder(builder: (context) {
                                    if (widget.movie.backdropPath == null) {
                                      return Center(
                                          child: Icon(
                                        Icons.error,
                                        color: Colors.grey,
                                      ));
                                    }
                                    try {
                                      String cleanBase64 = widget
                                          .movie.backdropPath!
                                          .split(',')
                                          .last;
                                      Uint8List imageBytes =
                                          base64Decode(cleanBase64);
                                      return Image.memory(imageBytes);
                                    } catch (e) {
                                      return Text(
                                          "Some error occurred while saving image!");
                                    }
                                  })
                                : CachedNetworkImage(
                                    imageUrl:
                                        "https://image.tmdb.org/t/p/original${widget.movie.backdropPath ?? ""}",
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        Center(
                                            child: CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress)),
                                    errorWidget: (context, url, error) =>
                                        Center(
                                            child: Icon(
                                      Icons.error,
                                      color: Colors.grey,
                                    )),
                                    fit: BoxFit.fill,
                                  );
                          },
                        );
                      },
                    ),
                  ],
                ),
                Positioned(
                    top: 20,
                    left: 5,
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ))),
                Positioned(
                    top: 20,
                    right: 5,
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.share,
                          color: Colors.white,
                        ))),
                Positioned(
                  top: 200,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: Colors.redAccent, width: 3)),
                            child: Container(
                              height: 260,
                              margin: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: Colors.white, width: 3)),
                              child:
                                  BlocBuilder<MoviesListBloc, MovieListState>(
                                builder: (context, allMoviesState) {
                                  return BlocBuilder<FavMoviesBloc,
                                      FavMoviesState>(
                                    builder: (context, state) {
                                      return allMoviesState is SwitchToFavState
                                          ? Builder(builder: (context) {
                                              if (widget.movie.posterPath ==
                                                  null) {
                                                return Center(
                                                    child: Icon(
                                                  Icons.error,
                                                  color: Colors.grey,
                                                ));
                                              }
                                              try {
                                                String cleanBase64 = widget
                                                    .movie.posterPath!
                                                    .split(',')
                                                    .last;
                                                Uint8List imageBytes =
                                                    base64Decode(cleanBase64);
                                                return Image.memory(imageBytes);
                                              } catch (e) {
                                                return Text(
                                                    "Some error occurred while saving image!");
                                              }
                                            })
                                          : CachedNetworkImage(
                                              imageUrl:
                                                  "https://image.tmdb.org/t/p/original${widget.movie.posterPath ?? ""}",
                                              progressIndicatorBuilder: (context,
                                                      url, downloadProgress) =>
                                                  Center(
                                                      child: CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress)),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Center(
                                                          child: Icon(
                                                Icons.error,
                                                color: Colors.grey,
                                              )),
                                              fit: BoxFit.fill,
                                            );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: w * 0.3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.movie.title ?? "",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  DateFormat("MMM yyyy").format(
                                      widget.movie.releaseDate ??
                                          DateTime.now()),
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  "Average Rating: ${widget.movie.voteAverage?.toStringAsFixed(1)}",
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          BlocBuilder<FavMoviesBloc, FavMoviesState>(
                            builder: (context, state) {
                              if (state is SavingToFav &&
                                  state.movieId == widget.movie.movieId) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator()),
                                );
                              }

                              return IconButton(
                                  key: AppWidgetKeys.favIconKey,
                                  onPressed: () {
                                    !state.movies
                                            .map((m) => m.movieId)
                                            .toList()
                                            .contains(widget.movie.movieId)
                                        ? context
                                            .read<FavMoviesBloc>()
                                            .add(AddFavMovieEvent(widget.movie))
                                        : context.read<FavMoviesBloc>().add(
                                            RemoveFavMovieEvent(widget.movie));
                                  },
                                  icon: Icon(
                                    !state.movies
                                            .map((m) => m.movieId)
                                            .toList()
                                            .contains(widget.movie.movieId)
                                        ? Icons.favorite_border_outlined
                                        : Icons.favorite,
                                    color: Colors.red,
                                    size: 30,
                                  ));
                            },
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                          width: w,
                          height: 2,
                          child: Divider(
                            color: Colors.grey,
                          )),
                      SizedBox(height: 20),
                      SizedBox(
                          width: w * 0.8,
                          child: Text(
                            widget.movie.overview ?? "",
                            style: TextStyle(color: Colors.grey),
                          )),
                      SizedBox(height: 20),
                      SizedBox(
                          width: w,
                          height: 2,
                          child: Divider(
                            color: Colors.grey,
                          )),
                      SizedBox(height: 20),
                      SizedBox(
                          width: w * 0.8,
                          child: Wrap(
                            spacing: 8,
                            children: List.generate(
                                widget.movie.genreIds?.length ?? 0, (index) {
                              return Chip(
                                  elevation: 20,
                                  backgroundColor:
                                      const Color.fromARGB(255, 204, 204, 204),
                                  label: Text(
                                    getGenre(
                                      widget.movie.genreIds?[index] ?? 28,
                                    ),
                                    style: TextStyle(color: Colors.black),
                                  ));
                            }),
                          ))
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
