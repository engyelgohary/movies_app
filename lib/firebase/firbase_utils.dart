import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
class FirebaseUtils {
  static CollectionReference getFilmCollection() {
    return FirebaseFirestore.instance.collection('films');
  }

  static Future<DocumentReference> addFilmToFirestore(Map<String, dynamic> filmData) async {
    CollectionReference filmsCollection = getFilmCollection();

    DocumentReference newDocRef = await filmsCollection.add(filmData);

    await newDocRef.update({'id': newDocRef.id});

    return newDocRef;  }

  static Future<void> deleteFilm(String filmId) async {
    try {
      await getFilmCollection().doc(filmId).delete();
    } catch (e) {
      print('Error deleting film: $e');
      throw e;
    }
  }
  static Future<void> fetchAndStoreDataFromAPIs() async {
    try {
      var popularData = await fetchDataFromAPI('https://api.themoviedb.org/3/movie/popular');
      var upcomingData = await fetchDataFromAPI('https://api.themoviedb.org/3/movie/upcoming');
      var topRatedData = await fetchDataFromAPI('https://api.themoviedb.org/3/movie/top_rated');
      var similarData = await fetchDataFromAPI('https://api.themoviedb.org/3/movie/{movie_id}/similar');
      var processedData = processData(popularData, upcomingData, topRatedData, similarData);
      await storeDataInFirestore(processedData);
    } catch (e) {
      print('Error fetching and storing data: $e');
      throw e;
    }
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

  static Map<String, dynamic> processData(Map<String, dynamic> popularData, Map<String, dynamic> upcomingData, Map<String, dynamic> topRatedData, Map<String, dynamic> similarData) {
    Map<String, dynamic> combinedData = {
      'popular': popularData,
      'upcoming': upcomingData,
      'topRated': topRatedData,
      'similar':similarData
    };

    return combinedData;
  }
  static Future<String?> getFilmId(String filmTitle) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('films')
          .where('title', isEqualTo: filmTitle)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching film ID: $e');
      return null;
    }
  }
  static Future<void> storeDataInFirestore(Map<String, dynamic> filmsData) async {
  }



}

void main() async {
  await FirebaseUtils.fetchAndStoreDataFromAPIs();
}