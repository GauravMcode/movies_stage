import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_stage/domain/repositories/fav_movies_repository.dart';
import 'package:movies_stage/presentation/movies_list/bloc/fav_movies_events.dart';

class FavMoviesBloc extends Bloc<FavMoviesEvents, FavMoviesState> {
  FavMoviesBloc() : super(InitialFavMovieState()) {
    on<GetFavMoviesEvent>((event, emit) async {
      final movies = state.movies;
      emit(LoadingFavMovieState(movies: movies));
      final res = await FavMoviesRepository.getFavMovies();
      if (res != null) {
        movies.addAll(res);
        emit(FetchedFavMovieState(movies: movies));
      } else {
        emit(ErrorFavMoviesState(movies: movies, error: "Some error occured"));
      }
    });

    on<AddFavMovieEvent>((event, emit) async {
      final movies = state.movies;
      emit(SavingToFav(movies: movies, movieId: event.movie.movieId));
      final movie = await FavMoviesRepository.addToFav(event.movie);
      movies.add(movie);
      emit(FetchedFavMovieState(movies: movies));
    });

    on<RemoveFavMovieEvent>((event, emit) async {
      final movies = state.movies;
      movies.removeWhere((m) => m.movieId == event.movie.movieId);
      await FavMoviesRepository.removeFromFav(event.movie);
      emit(FetchedFavMovieState(movies: movies));
    });
  }
}
