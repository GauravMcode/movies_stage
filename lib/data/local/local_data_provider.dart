import 'package:isar/isar.dart';
import 'package:movies_stage/domain/models/movie.dart';
import 'package:movies_stage/utils.dart';
import 'package:path_provider/path_provider.dart';

class LocalDataProvider {
  static Isar? isar;

  initIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [MovieSchema],
      directory: dir.path,
    );
  }

  Future<List<Movie>?> getFavMovies() async {
    if (isar == null) {
      await initIsar();
    }
    List<Movie> movies = [];
    try {
      movies = await isar!.movies.where().findAll();
    } catch (e) {
      showToast("error in fetching Fav movies");
      return null;
    }
    for (var mov in movies) {
      print(mov.posterPath);
    }
    return movies;
  }

  saveMovie(Movie movie) async {
    if (isar == null) {
      await initIsar();
    }
    if (movie.backdropPath != null) {
      try {
        movie.backdropPath =
            await fetchImageFromUrlAndConvertToBase64(movie.backdropPath!);
      } catch (e) {
        print("cant convert to image");
        movie.backdropPath = null;
      }
    }
    if (movie.posterPath != null) {
      try {
        movie.posterPath =
            await fetchImageFromUrlAndConvertToBase64(movie.posterPath!);
      } catch (e) {
        print("cant convert to image");
        movie.posterPath = null;
      }
    }
    await isar!.writeTxn(() async {
      await isar!.movies.put(movie);
    });
  }

  removeMovie(Movie movie) async {
    if (isar == null) {
      await initIsar();
    }
    await isar!.writeTxn(() async {
      await isar!.movies.delete(movie.id);
    });
  }
}
