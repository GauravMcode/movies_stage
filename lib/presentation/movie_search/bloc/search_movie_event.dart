import 'package:movies_stage/domain/models/movie.dart';

sealed class SearchMovieEvent {}

class GetSearchMoviesEvent extends SearchMovieEvent {
  String searchTerm;
  GetSearchMoviesEvent(this.searchTerm);
}

sealed class SearchMovieState {
  List<Movie> movies = [];
  SearchMovieState(this.movies);
}

class InitialSearchMovieState extends SearchMovieState {
  InitialSearchMovieState() : super([]);
}

class LoadingSearchMovieState extends SearchMovieState {
  LoadingSearchMovieState({required List<Movie> movies})
      : super(movies);
}

class FetchedSearchedMovieState extends SearchMovieState {
  FetchedSearchedMovieState({required List<Movie> movies})
      : super(movies);
}

class ErrorSearchMoviesState extends SearchMovieState {
  String error;
  ErrorSearchMoviesState(
      {required List<Movie> movies, required this.error})
      : super(movies);
}
