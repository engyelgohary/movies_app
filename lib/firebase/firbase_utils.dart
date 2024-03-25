import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/model/Popular.dart';

class FirebaseUtils {
  static CollectionReference getFilmCollection() {
    return FirebaseFirestore.instance.collection(Results.collectionName);
  }

  static Future<List<Results>> getFilms() async {
    final querySnapshot = await getFilmCollection().get();
    return querySnapshot.docs.map((doc) => Results.fromJson(doc.data())).toList();
  }

  static Future<DocumentReference> addFilmToFireStore({required Results result}) async {
    return getFilmCollection().add(result.toJson());
  }
}