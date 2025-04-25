import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_stage/domain/models/movie.dart';
import 'package:movies_stage/domain/repositories/all_movies_repository.dart';
import 'package:movies_stage/presentation/movie_search/bloc/search_movie_event.dart';

class SearchMoviesBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  SearchMoviesBloc() : super(InitialSearchMovieState()) {
    on<GetSearchMoviesEvent>((event, emit) async {
      List<Movie> movies = state.movies;
      emit(LoadingSearchMovieState(movies: movies));
      final res = await AllMoviesRepository.searchMovieList(event.searchTerm);
      if (res['status'] == 200) {
        movies = res['movies'];
        emit(FetchedSearchedMovieState(movies: movies));
      } else {
        emit(ErrorSearchMoviesState(
            movies: movies, error: res['message'].toString()));
      }
    });
  }
}
