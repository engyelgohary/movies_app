import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
class FirebaseUtils {
  static CollectionReference getFilmCollection() {
    return FirebaseFirestore.instance.collection('films');
  }

  static Future<DocumentReference> addFilmToFirestore(Map<String, dynamic> filmData) async {
    return getFilmCollection().add(filmData);
  }

  static Future<void> deleteFilm(String filmId) async {
    try {
      await getFilmCollection().doc(filmId).delete();
    } catch (e) {
      print('Error deleting film: $e');
      throw e; // Re-throw the error to handle it wherever you call this method
    }
  }
  static Future<void> fetchAndStoreDataFromAPIs() async {
    var popularData = await fetchDataFromAPI('https://api.themoviedb.org/3/movie/popular');

    var upcomingData = await fetchDataFromAPI('https://api.themoviedb.org/3/movie/upcoming');

    var topRatedData = await fetchDataFromAPI('https://api.themoviedb.org/3/movie/top_rated');

  }

  static Future<Map<String, dynamic>> fetchDataFromAPI(String apiUrl) async {
    try {
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data from API');
      }
    } catch (e) {
      print('Error fetching data from API: $e');
      throw Exception('Failed to load data from API');
    }
  }

  static Map<String, dynamic> processData(Map<String, dynamic> popularData, Map<String, dynamic> upcomingData, Map<String, dynamic> topRatedData) {
    // Perform processing on the data and combine them into a single map
    Map<String, dynamic> combinedData = {
      'popular': popularData,
      'upcoming': upcomingData,
      'topRated': topRatedData,
    };

    return combinedData;
  }

  static Future<void> storeDataInFirestore(Map<String, dynamic> filmsData) async {
  }

}

void main() async {
  await FirebaseUtils.fetchAndStoreDataFromAPIs();
}