
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/smiler_model.dart';

class FirebaseUtilsDetials {

  static CollectionReference<SimilarResults> getFilmCollection() {
    return FirebaseFirestore.instance.collection('Films')
        .withConverter<SimilarResults>
      (
        fromFirestore: ((snapshot, options) =>
            SimilarResults.fromJson(snapshot.data()!)),
        toFirestore: (result, options) => result.toJson());
  }
  static Future<DocumentReference> addFilmToFireStore({required SimilarResults result}) async {
    return getFilmCollection().add(result);
  }
}