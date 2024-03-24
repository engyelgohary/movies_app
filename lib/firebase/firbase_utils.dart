import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies_app/model/Popular.dart';


class FirebaseUtils {

  static CollectionReference<Results> getFilmCollection() {
    return FirebaseFirestore.instance.collection(Results.collectionName)
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