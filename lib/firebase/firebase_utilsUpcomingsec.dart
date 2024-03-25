import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/upcomingfilm.dart';

class FirebaseUtilsUpComingSec {

  static CollectionReference<Results> getFilmCollection() {
    return FirebaseFirestore.instance.collection('Films')
        .withConverter<Results>
      (
        fromFirestore: ((snapshot, options) =>
            Results.fromJson(snapshot.data())),
        toFirestore: (result, options) => result.toJson());
  }
  static Future<DocumentReference> addFilmToFireStore({required Results result}) async {
    return getFilmCollection().add(result);
  }
}