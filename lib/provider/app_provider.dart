// import 'package:flutter/material.dart';
// import 'package:movies_app/firebase/firbase_utils.dart';

// import '../Model/upcomingfilm.dart';

// class AppProvider extends ChangeNotifier{
//     Future<List<Results>> getFilms() async {
//     final querySnapshot = await FirebaseUtils.getFilmCollection().get();
//     return querySnapshot.docs.map((doc) => Results.fromJson(doc.data())).toList();
//   }
// }