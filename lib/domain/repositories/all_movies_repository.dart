import 'dart:convert';

import 'package:movies_stage/data/remote/remote_data_provider.dart';
import 'package:movies_stage/domain/models/movie.dart';

class AllMoviesRepository {
  static Future<Map<String, dynamic>> getMovieList(int page) async {
    List<Movie> movies = [];
    final res = await RemoteDataProvider().fetchMoviesList(page);
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      if ((data)['results']==null) {
      return {'movies': movies, 'status': 22, 'message': data['status_message']};
        
      }
      movies = movieListFromJson(res.body);
      return {'movies': movies, 'status': 200, 'message': "success"};
    } else {
      return {'movies': movies, 'status': res.statusCode, 'message': res.body};
    }
  }
}
