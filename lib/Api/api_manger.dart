import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiManager {
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
}
