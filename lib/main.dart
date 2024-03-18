import 'package:flutter/material.dart';
import 'package:movies_app/Movies/discover/discover_screen.dart';
import 'homescreen.dart';
import 'model/ListsMovies.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        DiscoverMovie.routeName:(context)=> DiscoverMovie()
      },
    );
  }
}




