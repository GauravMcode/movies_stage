import 'package:movies_stage/domain/models/movie.dart';

sealed class FavMoviesEvents {}

class GetFavMoviesEvent extends FavMoviesEvents {}

class AddFavMovieEvent extends FavMoviesEvents {
  Movie movie;
  AddFavMovieEvent(this.movie);
}

class RemoveFavMovieEvent extends FavMoviesEvents {
  Movie movie;
  RemoveFavMovieEvent(this.movie);
}

sealed class FavMoviesState {
  List<Movie> movies = [];
  FavMoviesState(this.movies);
}

class InitialFavMovieState extends FavMoviesState {
  InitialFavMovieState() : super([]);
}

class LoadingFavMovieState extends FavMoviesState {
  LoadingFavMovieState({required List<Movie> movies}) : super(movies);
}

class FetchedFavMovieState extends FavMoviesState {
  FetchedFavMovieState({required List<Movie> movies}) : super(movies);
}

class ErrorFavMoviesState extends FavMoviesState {
  String error;
  ErrorFavMoviesState({required List<Movie> movies, required this.error})
      : super(movies);
}
