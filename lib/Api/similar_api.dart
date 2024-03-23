import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/Model/smiler_model.dart';

class SimilarApi{
  static Future<SimilarModel> getSimilarMovies(int mId) async {
    Uri url = Uri.https(SimilarConstant.baseUrl,'/3/movie/${mId}/similar',
        {
          'api_key' :SimilarConstant.apiKey,
        }
    );
    try {
      var response= await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return SimilarModel.fromJson(json);
    } on Exception catch (e) {
      throw e;
    }

  }
}
class SimilarConstant{
  static const String apiKey ='9f85500ba6ab01fcf71fc13b24da6acd';
  static const String baseUrl = 'api.themoviedb.org';
}
/*
https://api.themoviedb.org/3/movie/{movie_id}/similar
 */