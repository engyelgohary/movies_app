import '../model/ListsMovies.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class ApiMoviesLists {
  static Future<ListsMovies?> getUpFilms() async {
    Uri url = Uri.https(ApiConstant.baseURL,ApiConstant.filmApi,
        {
          'api_key':'c1265a8ce88388fdd90cabcf16515a92',
        });
    try{
      var upFilm = await http.get(url);
      var upFilmbody = upFilm.body;
      var json = jsonDecode(upFilmbody);
      return ListsMovies.fromJson(json);
    }catch(e){
      throw e;
    }

  }
}


class ApiConstant {
  static const String baseURL = 'api.themoviedb.org';
  static const String filmApi = '/3/genre/movie/list';
}