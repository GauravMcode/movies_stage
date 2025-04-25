import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:movies_stage/config/routes/api_routes.dart';
import 'package:movies_stage/utils.dart';

/*  
Note: I have to call TMDB API from Supabase Serverless function deployed outside
*India, because some of the ISPs have banned access to TMDB. Therefore, wasn't
able to call from the App directly.
*/

class RemoteDataProvider {
  Future<http.Response> fetchMoviesList(int page) async {
    try {
      final res = await http.get(Uri.parse(ApiRoutes.getMovies + page.toString()));
      return res;
    } on SocketException {
      showToast("Connection error");
      return http.Response("connection error", 503);
    }on http.ClientException catch (e) {
    print("🔌 Client error: $e");
      return http.Response("connection error", 503);

  } 
     catch (e) {
      return http.Response(e.toString(), 400);
    }
  }
}


