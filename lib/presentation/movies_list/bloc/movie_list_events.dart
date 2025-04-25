import 'package:movies_stage/domain/models/movie.dart';

sealed class MovieListEvent {}

class GetMoviesEvent extends MovieListEvent {
  GetMoviesEvent();
}

class SwitchToFavEvent extends MovieListEvent {
  SwitchToFavEvent();
}

sealed class MovieListState {
  List<Movie> movies = [];
  int page;
  MovieListState(this.movies, this.page);
}

class InitialMovieState extends MovieListState {
  InitialMovieState() : super([], 1);
}

class LoadingMovieState extends MovieListState {
  LoadingMovieState({required List<Movie> movies, required int page})
      : super(movies, page);
}

class SwitchToFavState extends MovieListState {
  SwitchToFavState({required List<Movie> movies, required int page})
      : super(movies, page);
}

class FetchedAllMovieState extends MovieListState {
  FetchedAllMovieState({required List<Movie> movies, required int page})
      : super(movies, page);
}

class FetchedFavMovieState extends MovieListState {
  FetchedFavMovieState({required List<Movie> movies, required int page})
      : super(movies, page);
}

class ErrorMoviesState extends MovieListState {
  String error;
  ErrorMoviesState(
      {required List<Movie> movies, required int page, required this.error})
      : super(movies, page);
}
