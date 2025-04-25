/*  
Note: I have to call TMDB API from Supabase Serverless function deployed outside
*India, because some of the ISPs have banned access to TMDB. Therefore, wasn't
able to call from the App directly.
*/
class ApiRoutes {
  static const getMovies = "https://pdsqfldbqrjlrxqkzawf.supabase.co/functions/v1/hello-world?page=";
  static const searchMovies = "https://pdsqfldbqrjlrxqkzawf.supabase.co/functions/v1/search_movies?search=";
}
