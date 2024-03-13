import 'package:flutter/material.dart';
import 'package:movies_app/Api/api_manger.dart';
import 'package:movies_app/Theme/mytheme.dart';

import 'Popular_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> movies = [];

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }
  Future<void> _fetchMovies() async {
    try {
      List<Map<String, dynamic>>? fetchedMovies = await ApiManager.getMovies(page: 1);
      setState(() {
        movies = fetchedMovies!;
      });
    } catch (error) {
      // Handle error
      print('Error fetching movies: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.backgroundColor,
      appBar: AppBar(backgroundColor: MyTheme.backgroundColor,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PopularItems(movies: movies),
        ],
        ),
      ),
    );
  }
}