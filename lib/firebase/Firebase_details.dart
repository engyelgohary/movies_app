
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/Model/movie_details_model.dart';

class FirebaseUtilsDetials {

  static CollectionReference<MovieDetailsModel> getFilmCollection() {
    return FirebaseFirestore.instance.collection('Films')
        .withConverter<MovieDetailsModel>
      (
        fromFirestore: ((snapshot, options) =>
            MovieDetailsModel.fromJson(snapshot.data()!)),
        toFirestore: (result, options) => result.toJson());
  }
  static Future<DocumentReference> addFilmToFireStore({required MovieDetailsModel result}) async {
    return getFilmCollection().add(result);
  }
}