import 'package:movies_stage/data/local/local_data_provider.dart';
import 'package:movies_stage/domain/models/movie.dart';

class FavMoviesRepository {
  static Future<List<Movie>?>getFavMovies() async {
    return await LocalDataProvider().getFavMovies();
  }
  static  addToFav(Movie movie) async {
    return await LocalDataProvider().saveMovie(movie);
  }
  static removeFromFav(Movie movie) async {
    return await LocalDataProvider().removeMovie(movie);
  }
}
