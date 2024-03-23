import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Model/MovieDiscover.dart';

class ApiManager {
  static const String apiKey = '02f2d0cc900775cf6f1018b35e266f3c';
  static const String baseUrl = 'https://api.themoviedb.org/3';

  static Future<List<Map<String, dynamic>>?> getMovies({required int page}) async {
    String apiKey = '02f2d0cc900775cf6f1018b35e266f3c';
    Uri url = Uri.https(
      'api.themoviedb.org',
      '/3/movie/popular',
      {'api_key': apiKey},
    );
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(json['results']);
      } else {
        print('Failed to load data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  static Future<MovieDiscover> getMoviesDiscover() async {
    Uri url = Uri.parse('$baseUrl/discover/movie?api_key=$apiKey');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return MovieDiscover.fromJson(json);
      } else {
        throw Exception('Failed to load movies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');

    }}
  static Future<List<Results>> fetchMoviesByCategory(int categoryId) async {
    final String apiKey = '02f2d0cc900775cf6f1018b35e266f3c';
    final String baseUrl = 'https://api.themoviedb.org/3';

    final Uri url = Uri.parse('$baseUrl/discover/movie?api_key=$apiKey&with_genres=$categoryId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<Results> movies = []; // List to store the fetched movies

        // Parse the JSON data and create a list of Movie objects
        for (var item in jsonData['results']) {
          movies.add(Results.fromJson(item));
        }

        return movies;
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      throw Exception('Error fetching movies: $e');
    }
  }
}

