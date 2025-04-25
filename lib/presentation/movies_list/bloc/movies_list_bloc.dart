import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_stage/domain/repositories/all_movies_repository.dart';
import 'package:movies_stage/presentation/movies_list/bloc/movie_list_events.dart';

class MoviesListBloc extends Bloc<MovieListEvent, MovieListState> {
  MoviesListBloc() : super(InitialMovieState()) {
    on<GetMoviesEvent>((event, emit) async {
      final movies = state.movies;
      int page = state.page;
      emit(LoadingMovieState(movies: movies, page: page));
      final res = await AllMoviesRepository.getMovieList(page);
      if (res['status'] == 200) {
        movies.addAll(res['movies']);
        if (state is! SwitchToFavState) page++;
        emit(FetchedAllMovieState(movies: movies, page: page));
      } else {
        emit(ErrorMoviesState(
            movies: movies, error: res['message'].toString(), page: page));
      }
    });

    on<SwitchToFavEvent>((event, emit) async {
      final movies = state.movies;
      int page = state.page;
      emit(SwitchToFavState(movies: movies, page: page));
    });
  }
}
