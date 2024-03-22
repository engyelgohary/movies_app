import 'dart:convert';
import 'dart:math';

import 'package:movies_app/Api/toprated_api.dart';
import 'package:movies_app/Model/search_model.dart';
import 'package:http/http.dart' as http;

class SearchApi {
  static Future<SearchModel> getSearchMovies(String query) async {
    Uri url = Uri.parse(
        'https://api.themoviedb.org/3/search/movie?query=$query&api_key=9f85500ba6ab01fcf71fc13b24da6acd');

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print('Sucess');
      return SearchModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load');
  }
}
