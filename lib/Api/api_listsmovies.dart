import '../model/ListsMovies.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class ApiMoviesLists {
  static Future<List<MovieGenre>> fetchGenres() async {
    final apiKey = 'c1265a8ce88388fdd90cabcf16515a92';
    final response = await http.get(
      Uri.https('api.themoviedb.org', '/3/genre/movie/list', {'api_key': apiKey}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['genres'];
      return data.map((json) => MovieGenre.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load genres');
    }
  }
}
