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

  Future<Movie> saveMovie(Movie movie) async {
    final toAdd = movie.copyWith();
    toAdd.id = movie.movieId;
    if (isar == null) {
      await initIsar();
    }
    if (toAdd.backdropPath != null) {
      try {
        toAdd.backdropPath =
            await fetchImageFromUrlAndConvertToBase64(toAdd.backdropPath!);
      } catch (e) {
        print("cant convert to image");
        toAdd.backdropPath = null;
      }
    }
    if (toAdd.posterPath != null) {
      try {
        toAdd.posterPath =
            await fetchImageFromUrlAndConvertToBase64(toAdd.posterPath!);
      } catch (e) {
        print("cant convert to image");
        toAdd.posterPath = null;
      }
    }
    print(toAdd);
    await isar!.writeTxn(() async {
      await isar!.movies.put(toAdd);
    });
    return toAdd;
  }

  removeMovie(Movie movie) async {
    if (isar == null) {
      await initIsar();
    }
    final toRemove =
        await isar!.movies.filter().movieIdEqualTo(movie.movieId).findFirst();
    if (toRemove == null) {
      return;
    }
    await isar!.writeTxn(() async {
      await isar!.movies.delete(toRemove.id);
    });
  }
}
