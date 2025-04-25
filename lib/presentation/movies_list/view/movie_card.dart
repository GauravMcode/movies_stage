import 'dart:convert';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_stage/domain/models/movie.dart';
import 'package:movies_stage/presentation/movies_list/bloc/fav_movies_bloc.dart';
import 'package:movies_stage/presentation/movies_list/bloc/fav_movies_events.dart';
import 'package:movies_stage/presentation/movies_list/bloc/movie_list_events.dart';
import 'package:movies_stage/presentation/movies_list/bloc/movies_list_bloc.dart';
import 'package:movies_stage/utils.dart';

class MovieCard extends StatefulWidget {
  const MovieCard({required this.movie, super.key});
  final Movie movie;

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LayoutBuilder(builder: (context, constraints) {
      final w = constraints.maxWidth;
      return Container(
        margin: EdgeInsets.zero,
        child: Stack(
          children: [
            BlocBuilder<MoviesListBloc, MovieListState>(
              builder: (context, allMoviesState) {
                return BlocBuilder<FavMoviesBloc, FavMoviesState>(
                  builder: (context, state) {
                    return allMoviesState is SwitchToFavState
                        ? Builder(builder: (context) {
                            if (widget.movie.posterPath == null) {
                              return Center(
                                  child: Icon(
                                Icons.error,
                                color: Colors.grey,
                              ));
                            }
                            try {
                              String cleanBase64 =
                                  widget.movie.posterPath!.split(',').last;
                              Uint8List imageBytes = base64Decode(cleanBase64);
                              return Image.memory(imageBytes);
                            } catch (e) {
                              return Text(
                                  "Some error occurred while saving image!");
                            }
                          })
                        : CachedNetworkImage(
                            imageUrl:
                                "https://image.tmdb.org/t/p/original${widget.movie.posterPath ?? ""}",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress)),
                            errorWidget: (context, url, error) => Center(
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
           
            Positioned(
              bottom: 0,
              left: 4,
              right: 4,
              child: Container(
                color: Colors.black.withOpacity(0.6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.movie.title.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.movie.genreIds != null &&
                                widget.movie.genreIds?.isNotEmpty == true
                            ? SizedBox(
                                width: w * 0.7,
                                child: Text(
                                  getTextFromGenres(widget.movie.genreIds!),
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.white),
                                ))
                            : SizedBox(),
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
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

String getTextFromGenres(List<int> ids) {
  String genres = "";
  for (var id in ids) {
    genres += getGenre(id);
    if (ids.last != id) {
      genres += ", ";
    }
  }
  return genres;
}
