// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:movies_app/Home/movie_details/Similar_item.dart';
import 'package:movies_app/Home/movie_details/similar_widget.dart';
import 'package:movies_app/Model/smiler_model.dart';
import 'package:movies_app/Theme/mytheme.dart';

class DetailsScreen extends StatelessWidget {
//  SimilarResults similarResults;
  int movieId;
  DetailsScreen({
    Key? key,
  //  required this.similarResults,
    required this.movieId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, 
        icon: Icon(Icons.arrow_back,color: Colors.black,)),
      ),
      body: Column(
        children: [
          // SimilarWidget(results: results)
        ],
      ),
    );
  }
}
