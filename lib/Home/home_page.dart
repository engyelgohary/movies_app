// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:movies_app/Api/api_manger.dart';
import 'package:movies_app/Model/smiler_model.dart';

import 'UpComingsection/upcoming_details.dart';
import 'popularsec/Popular_item.dart';
import 'topRatedSec/toprated_widget.dart';

class HomePage extends StatefulWidget {
   HomePage({
    Key? key,
  }) : super(key: key);

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
    return
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PopularItems(movies: movies),
            SizedBox(height:20),
            UpComing_details(),
            SizedBox(height:20),
            TopRatedWidget(),
          ],
        ),
      );
  }
}